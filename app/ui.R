library(ggvis)
library(shiny)
library(shinythemes)
library(MASS)
library(jtools)
library(learnr)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

ui <- tagList(
  fluidPage(theme = shinytheme("cosmo")),
  navbarPage(
    "So Very Glaswegian",
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
               tabsetPanel(
                 tabPanel("Prediction and Inference",
                          plotOutput("scatterPlot"),
                          plotOutput("distPlot")
                 ),
                 tabPanel("R Tutorials", "This panel is intentionally left blank"),
                 tabPanel("Linear Regression", "This panel is intentionally left blank"),
                 tabPanel("Logistic Regression", "This panel is intentionally left blank")
               )
             )
    ),
    tabPanel("R Code Tutorials",
           mainPanel(
             "Hello I hear you'd like to learn some R",
             quiz(
               question("What number is the letter A in the English alphabet?",
                        answer("8"),
                        answer("14"),
                        answer("1", correct = TRUE),
                        answer("23"),
                        allow_retry = TRUE
               ),
               question("Please kill me?",
                        answer("No, suffer through", correct = TRUE),
                        answer("Ok."),
                        answer("That would be too merciful", correct = TRUE),
                        answer("Stay alive."),
                        allow_retry = TRUE,
                        random_answer_order = TRUE
               )
             )
           )
    ),
    tabPanel("Embedding Tutorials?", 
       "Nope"
   ),
    tabPanel("Inference",
             mainPanel(
               "Assess importance (coefficients) of predictors, 
           What can your model tell you about relationships in your data?"
             )),
    tabPanel("Prediction", "CoDiNg TuToRiAlZ")
  )
)