library(ggvis)

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
    tabPanel("Prediction", "CoDiNg TuToRiAlZ"),
    tabPanel("Movie Explorer",
         fluidPage(
           titlePanel("Movie explorer"),
           fluidRow(
             column(3,
                    wellPanel(
                      h4("Filter"),
                      sliderInput("reviews", "Minimum number of reviews on Rotten Tomatoes",
                                  10, 300, 80, step = 10),
                      sliderInput("year", "Year released", 1940, 2014, value = c(1970, 2014),
                                  sep = ""),
                      sliderInput("oscars", "Minimum number of Oscar wins (all categories)",
                                  0, 4, 0, step = 1),
                      sliderInput("boxoffice", "Dollars at Box Office (millions)",
                                  0, 800, c(0, 800), step = 1),
                      selectInput("genre", "Genre (a movie can have multiple genres)",
                                  c("All", "Action", "Adventure", "Animation", "Biography", "Comedy",
                                    "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
                                    "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
                                    "Short", "Sport", "Thriller", "War", "Western")
                      ),
                      textInput("director", "Director name contains (e.g., Miyazaki)"),
                      textInput("cast", "Cast names contains (e.g. Tom Hanks)")
                    ),
                    wellPanel(
                      selectInput("xvar", "X-axis variable", axis_vars, selected = "Meter"),
                      selectInput("yvar", "Y-axis variable", axis_vars, selected = "Reviews"),
                      tags$small(paste0(
                        "Note: The Tomato Meter is the proportion of positive reviews",
                        " (as judged by the Rotten Tomatoes staff), and the Numeric rating is",
                        " a normalized 1-10 score of those reviews which have star ratings",
                        " (for example, 3 out of 4 stars)."
                      ))
                    )
             ),
             column(9,
                    ggvisOutput("plot1"),
                    wellPanel(
                      span("Number of movies selected:",
                           textOutput("n_movies")
                      )
                    )
             )
           )
        ))
  )
)