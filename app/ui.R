library(ggvis)
library(shiny)
library(shinythemes)
library(MASS)
library(jtools)
library(learnr)
library(xml2)

## TODO
# 1. Take out all stuff about linear regression
# 2. Put in logistic regression visualization from
# https://statquest.org/2018/07/23/statquest-logistic-regression-in-r/#code
#   visualize color as actual outcome
#   explain how line relates to prediction
#   Kat to code model
# 3. Sarah to find scatterplotty logistic regression
# 3.5 Tree write up plain text description of glm output
# 4. Carolyn nicely format all of Sarah's text/plug in Kat's visualization
# 5. R Code Tutorials by Sarah for logistic regression (content only)
# 6. Reflect Oscar's theme


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
           answer(sprintf("$\\sqrt{x} = %d$",  1)),
           answer(sprintf("$x ^ 2 = %d$", 2))
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

intro_text <- "Willkommen, bienvenue, welcome to our app. In this diminutive digital diorama we hope to explain and explore Logistic Regression and use this method as a case study in the principles, perks and perils of data modelling. "
intro_two <- "Before we dive into our model lets introduce you to our data set. What we have here is a record of all nominees for Best Picture Oscar between XXXX- and XXXX- Excitingly, we also have information on the budgets (adjusted for inflation), average critic rating (Rotten Tomatoes) and average audience rating (IMBD) for each movie."

logistic1 <- "For the purposes of this explanation we are going to, perhaps rather rudely, assume that you have some understanding of Linear Regression.  Logistic regression is similar to linear regression in that the model describes the relationship between one dependant or outcome variable and one or more independent or predictor variables. The big difference between a Linear and Logistic regression is that, whilst for linear regressions the outcome variable must be continuous, in the Logistic variation the outcome variable is dichotomous (a binary categorical distinction). For example:"
logistic2 <- "In logistic regression we examine the relationship between our predictor variables and the probability that an answer will be yes rather than no, right rather than wrong, covered in eels rather than not being covered in eels." 

logistic3 <- "Within the context of our dataset we want our model to accurately predict if a nominated film falls into the Won or Lost categories. Let’s begin by imagining we have no predictors. If this were a linear regression, with a continuous outcome like Box Office profit, then our best guess would be the mean (which would for the intercept in a linear model). However, when our outcome is binary (0 or 1) then taking a mean (0.5) is useless because in the context of categorical ratings 0.5 doesn’t mean anything…. unless you’re LaLa Land. Instead the base prediction for logistic regression could be derived from the number of cases. The number of nominees for Best Picture changes periodically but for 2019 there were 8 contestants of whom only 1 wins. So for a logistic regression a more informative intercept might be that a film has a baseline 1 in 8 chance of winning.  However, this alone is neither very informative or very interesting, imagine betting on a race where all the horses have 1/8 odds. This is where our predictors come in. We want to use our data to build a model which expresses the relationship between our predictors and the films chance of winning." 

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
               h2("Intro"),
               p(intro_text),
               p(intro_two),
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
           h2("Logistic Regression"),
           p(logistic1),
           tags$ul(
             tags$li("Yes/No"),
             tags$li("Correct/Wrong"),
             tags$li("Dead/Alive"),
             tags$li("Pregnant/Not-Pregnant"),
             tags$li("Things-which-are-fine/Things-which-are-covered-in-eels")
           ),
           p(logistic2),
           p(logistic3),
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