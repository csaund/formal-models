library(ggvis)
library(dplyr)
library(RSQLite)
library(dbplyr)

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
