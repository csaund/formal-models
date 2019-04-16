library(ggvis)
library(dplyr)
library(RSQLite)
library(dbplyr)
library(ggplot2)
library(tidyverse)

server = function(input, output) {
    
    # Fetch our tutorial app from where it's published as a separate shiny app
    output$tutorial <- renderUI({
      tags$iframe(
        src="https://ug-formal-models-2019.shinyapps.io/logistic-regression-code-tutorial/", width=1280, height=720
      )
    })

    # n is number of observations     
    # c is correlation coefficient
    # Since we're simulating our data we get to decide what we find, 
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
    
    # Generate the raw data plot for the home page
    output$rawPlot <- renderPlot({
      mydf = generate_logistic_data(100, 3) 
      mydf$y1 <- as.character(mydf$y)
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"Eels","No Eels")
      
      ggplot(data = mydf, aes(x1, y)) +
        geom_point(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        # Add a (fake) linear regression line for illustrative purposes
        geom_abline(intercept=1.4, slope=0.46) +
        ggtitle("Our Binary Data") +
        xlab("Predictor Variable") +
        ylab(" No Eels or Eels all over the shop")      
    })
    
    # Actual raw data that depends on input
    output$logisticRaw <- renderPlot({
      mydf = generate_logistic_data(input$logistic_n, input$c1) 
      mydf$y1 <- as.character(mydf$y)
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"No Oscar","Oscar")
      ggplot(data = mydf, aes(x1, y)) +
        geom_point(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        ggtitle("Our Binary Data") +
        xlab("Predictor Variable") +
        ylab("Movies Which Won an Oscar")
    })
    
    # Logistic plot for second page
    output$logisticPlot <- renderPlot({
      dat = generate_logistic_data(input$logistic_n, input$c1) 
      g <- glm( y~x1,family="binomial", data=dat)
      prob <- data.frame(predict(g, type = "response"))
      names(prob) <- c("prob")
      mydf <- dplyr::bind_cols(dat, prob) 
      mydf$y <- as.character(mydf$y)
      mydf$Actual_Outcome<- ifelse(mydf$y==0,"No Oscar","Oscar")
      
      
      ggplot(data = mydf, aes(x1, prob)) +
        geom_line(method = "glm", method.args = list(family = "binomial"), alpha=0.3) +
        geom_jitter(aes(color=Actual_Outcome, shape=Actual_Outcome, fill=Actual_Outcome), alpha=0.4, size=5) +
        ggtitle("Logistic Regression Model Fit") +
        xlab("Predictor Variable") +
        ylab("Predicted Probability")
    })

  }
