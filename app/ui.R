library(ggvis)
library(shiny)
library(shinythemes)
library(MASS)
library(jtools)
library(learnr)
library(xml2)


# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

R_quiz <- quiz(
  question("When is regression analysis *inappropriate*?",
           answer("you have two variables that are measured on an interval or ratio scale"),
           answer("you are trying to predict one variable from another"),
           answer("when plotted, your data forms a reasonably straight line"),
           answer("when plotted, your data is heteroscedastic", correct = TRUE)
  ),
  question("A regression line...",
           answer("passes through as many points as possible", correct = TRUE),
           answer("minimizes squared distance from the points", correct = TRUE),
           answer("goes through the average of each data point at a particular x value"),
           answer("is used to classify new data")
  ),
  question("As the correlation coefficient (r) gets larger, our prediction for Y (the dependent variable)...",
           answer("gets smaller"),
           answer("does not change"),
           answer("gets closer to the mean of Y"),
           answer("gets closer to the mean of X", correct = TRUE)
  ),
  # this should be a proper question where we give a regression equation and ask them to 
  # predict Y
  question("Which equation correctly describes the regression line for Y in relation to X?",
           answer(sprintf("$\\sqrt{x} = %d$", x + 1)),
           answer(sprintf("$x ^ 2 = %d$", x^2))
  ),
  question("What does 'MSE' mean?...",
           answer("placeholder"),
           answer("placeholder2", correct = TRUE)
  ),
  ## we can embed images here too
  question("What do you think this is a picture of?",
           answer("god only knows", correct=TRUE),
           answer("why would you choose a random image from your downloads for this?")
  )
)

# tag("a", list(href = "tutorial.Rmd", "R Quiz"))
# include an external link like this ^^

# https://www.google.com/search?q=how+to+use+logistic+regression&rlz=1C5CHFA_enUS747US750&oq=how+to+use+logistic+regression&aqs=chrome..69i57j0l5.4992j0j1&sourceid=chrome&ie=UTF-8
# also good resource

introductory_text <- "Take our example scenario and generate some data with it"

assumptions <- "These are some assumptions we have when using logistic regression: 
  we assume observations are independent
  assumes linear relationship
  normally distributed"

how_to_use <- "Use to explain relationship between binary DV and one or more nominal IVs"

ui <- tagList(
  fluidPage(theme = shinytheme("cosmo")),
  navbarPage(
    "Logistic Regression",
    tabPanel("Introduction",
             sidebarPanel(
               # don't need these for right now
               # fileInput("File", "File input:"),
               # textInput("txt", "Text input:", "general"),
               sliderInput("data_correlation", "Data correlation:", 0, 1, 0.3),
               sliderInput("litre_range", "Range of consumption:", 0, 40, 1),
               sliderInput("num_samples", "Number of datapoints:", 5, 500, 200)
               
               #tags$h5("Regenerate graph"),
               #actionButton("regenerate_data", "Action button", class = "btn-primary")
             ),
             mainPanel(
               "An Introduction to Logistic Regression",
               tabsetPanel(
                 tabPanel("Scenario", introductory_text),
                 tabPanel("Data Plot",
                          plotOutput("scatterPlot"),
                          plotOutput("distPlot")
                 ),
                 tabPanel("Linear Regression", "This panel is intentionally left blank"),
                 tabPanel("Logistic Regression", "This panel is intentionally left blank")
               )
             )
    ),
    tabPanel("Using Logistic Regression",
         mainPanel(
           "An Introduction to Why and How to use Logistic Regression as an evaluation and classification technique",
           tabsetPanel(
             tabPanel("When", assumptions),
             tabPanel("How", how_to_use)
           )
         )
    ),
    tabPanel("R Code Tutorials",
             # and this is where the output actually ends up. I think leaving it 
             # as its own proper tab is the way.
             htmlOutput("tutorial")
    ),
    tabPanel("Quiz",
           mainPanel(
             "Hello I hear you'd like to learn some R",
             R_quiz
           )
    )
  )
)