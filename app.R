#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

shinyApp(
  ui = tagList(
    fluidPage(theme = shinytheme("cosmo")),
    navbarPage(
      "And the Academy Award goes to...",
      tabPanel("Introduction",
               sidebarPanel(
                 fileInput("File", "File input:"),
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
  ),
  server = function(input, output) {
    output$txtout <- renderText({
      paste(input$txt, input$slider, format(input$date), sep = ", ")
    })
    output$table <- renderTable({
      head(cars, 4)
    })
  })

