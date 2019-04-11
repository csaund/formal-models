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
    )
  )
)