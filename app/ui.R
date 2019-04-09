library(ggvis)
library(shiny)
library(shinythemes)
library(MASS)
library(jtools)

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
               sliderInput("num_samples", "Number of datapoints:", 5, 500, 200),
               
               tags$h5("Regenerate graph"),
               actionButton("regenerate_data", "Action button", class = "btn-primary")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Prediction and Inference",
                          plotOutput("scatterPlot"),
                          plotOutput("distPlot")
                 ),
                 tabPanel("Working with Data", "This panel is intentionally left blank"),
                 tabPanel("Linear Regression", "This panel is intentionally left blank"),
                 tabPanel("Logistic Regression", "This panel is intentionally left blank")
               )
             )
    ),
    tabPanel("Building a Linear Model",
             sidebarPanel(
               fileInput("file", "File input:"),
               textInput("txt", "Text input:", "general"),
               sliderInput("slider", "Slider input:", 1, 100, 30),
               tags$h5("Deafult actionButton:"),
               actionButton("action", "Search"),
               
               tags$h5("actionButton with CSS class:"),
               actionButton("action2", "Action button", class = "btn-primary")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Prediction and Inference",
                          h4("Table"),
                          tableOutput("table"),
                          h4("Verbatim text output"),
                          verbatimTextOutput("txtout"),
                          h1("Header 1"),
                          h2("Header 2"),
                          h3("Header 3"),
                          h4("Header 4"),
                          h5("Header 5")
                 ),
                 tabPanel("Working with Data", "This panel is intentionally left blank"),
                 tabPanel("Linear Regression", "This panel is intentionally left blank"),
                 tabPanel("Logistic Regression", "This panel is intentionally left blank")
               )
             )),
    tabPanel("Adding Predictors", "Multiple Regression is Cool"),
    tabPanel("Inference",
             mainPanel(
               "Assess importance (coefficients) of predictors, 
           What can your model tell you about relationships in your data?"
             )),
    tabPanel("Prediction", "CoDiNg TuToRiAlZ")
  )
)