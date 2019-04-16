library(ggvis)
library(dplyr)
library(RSQLite)
library(dbplyr)
library(ggplot2)

server = function(input, output) {
  
    complement <- function(y, rho, x) {
      if (missing(x)) x <- rnorm(length(y)) # Optional: supply a default if `x` is not given
      y.perp <- residuals(lm(x ~ y))
      rho * sd(y.perp) * y + y.perp * sd(y) * sqrt(1 - rho^2)
    }
    
    scale_values <- function(data, tmin, tmax) {
      rmin <- min(data)
      rmax <- max(data)
      scaled <- ((data - rmin) / (rmax - rmin)) * (tmax - tmin) + tmin
      return(scaled)
    }
    
    # TODO this is where our tutorial app will be!!
    # It needs to be published in the shiny app site so I will work on that. 
    # Note: It only renders in-browser so just running the app locally will
    # not have it show up!
    output$tutorial <- renderUI({
      tags$iframe(
        src="https://ug-formal-models-2019.shinyapps.io/logistic-regression-code-tutorial/", width=1280, height=720
      )
    })

    # n is number of observations     
    # c's are parameters
    # Since we're simulating our data we get to decide what we find. 
    # We're going to decide how much these variable increase or decease the odds of our 
    # outcome. There will be roughly approxomite to the coefficent estimate we get out of 
    # our model (although not exact since we're radomly sampling from a normal distribution).
    generate_logistic_data <- function(n, c1) {
      #Next we want to make some coninuous variables
      x1 = rnorm(n)           # some continuous variables 
      x2 = rnorm(n)
      x3 = rnorm(n)
      z = 1 + c1*x1       # linear combination with a bias
      pr = 1/(1+exp(-z))         # pass through an inv-logit function
      y = rbinom(n,1,pr)      # bernoulli response variable
      df = data.frame(y=y,x1=x1,x2=x2,x3=x3) #pop them all into a data frame

      return(df)
    }
    
    output$rawPlot <- renderPlot({
      mydf = generate_logistic_data(input$logistic_n, input$c1) 
      mydf$y1 <- as.character(mydf$y)
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"Eels","No Eels")
      ggplot(data = mydf, aes(x1, y)) +
        geom_point(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        ggtitle("Our Binary Data") +
        xlab("Predictor Variable") +
        ylab(" No Eels or Eels all over the shop")      
    })
    
    output$logisticRaw <- renderPlot({
      mydf = generate_logistic_data(input$logistic_n, input$c1) 
      mydf$y1 <- as.character(mydf$y)
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"Eels","No Eels")
      ggplot(data = mydf, aes(x1, y)) +
        geom_point(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        ggtitle("Our Binary Data") +
        xlab("Predictor Variable") +
        ylab(" No Eels or Eels all over the shop")
    })
    
    output$logisticPlot <- renderPlot({
      dat = generate_logistic_data(input$logistic_n, input$c1) 
      g <- glm( y~x1,family="binomial", data=dat)
      prob <- data.frame(predict(g, type = "response"))
      names(prob) <- c("prob")
      mydf <- dplyr::bind_cols(dat, prob) 
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"Eels","No Eels")
      
      
      ggplot(data = mydf, aes(x1, prob)) +
        geom_line(method = "glm", method.args = list(family = "binomial"), alpha=0.3) +
        geom_jitter(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        ggtitle("Logistic Regression Model Fit") +
        xlab("Predictor Variable") +
        ylab("Predicted Probability")
    })
    
    output$logisticLine <- renderPlot({
      dat = generate_logistic_data(input$logistic_n, input$c1) 
      ggplot(data = mydf, aes(x1, prob)) +
        geom_point(aes(color = y), alpha = .15, shape = 4) +
        geom_smooth(method = "glm", method.args = list(family = "binomial")) +
        ggtitle("Logistic regression model fit") +
        xlab("X1") +
        ylab("Probability")
    })
    
    generate_data <- function(num_samples, correlation) {
      ages <- runif(num_samples, min=0, max=87)
      vals <- 1:num_samples # Optional
      y = as.vector(sapply(correlation, function(correlation) complement(ages, correlation, vals)))
      # hard code y range to 0-40
      litres_per_month = scale_values(y, 0, input$litre_range)
      X <- data.frame(litres_per_month,
                      correlation=ordered(rep(signif(correlation, 2))),
                      ages=ages) 
      return(X)
    }
    
    
    output$scatterPlot <- renderPlot({
      d <- generate_data(input$num_samples, input$data_correlation)
      ggplot(d, aes(ages,litres_per_month, group=correlation)) + 
        geom_smooth(method="lm", color="Black") + 
        geom_point(aes(fill=correlation), alpha=1/2) 
    })
    

  }
