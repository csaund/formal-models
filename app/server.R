library(ggvis)
library(dplyr)

library(RSQLite)
library(dbplyr)

server = function(input, output) {
  
    generate_data <- function(num_samples, correlation) {
      data <- rmvnorm(n=num_samples,
                      mean=c(20,40),
                      sigma=matrix(c(5, correlation * sqrt(50), correlation * sqrt(50), 10), 2, 2))
      return(data)
    }
  
    output$scatterPlot <- renderPlot({
      plot(generate_data(input$num_samples, input$data_correlation))
    })
    
    output$distPlot <- renderPlot({
      states <- as.data.frame(state.x77)
      fit <- lm(Income ~ Frost + Illiteracy + Murder, data = states)
      effect_plot(fit, pred = Illiteracy, interval = TRUE, plot.points = TRUE)
      
      #x <- faithful$waiting
      #bins <- seq(min(x), max(x), length.out = 20 + 1)
      #
      #hist(x, breaks = bins, col = "#75AADB", border = "white",
      #     xlab = "Waiting time to next eruption (in mins)",
      #     main = "Histogram of waiting times")
      
    })
  }
