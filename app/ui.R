library(ggvis)
library(shiny)
library(shinythemes)
library(MASS)
library(jtools)
library(learnr)
library(xml2)

R_quiz <- quiz(
  question("In a logistic regression the predictor variables can be ",
           answer("categorical"),
           answer("continuous"),
           answer("both", correct=TRUE)
  ),
  question("If you want to find out how much a single factor influence the probability of an outcome which output parameter would be most informative?",
           answer("Intercept coefficent"),
           answer("Variable coefficent", correct = TRUE),
           answer("AIC value")
  ),
  question("The inital output coefficents from a logistic regression represent ",
           answer("probability"),
           answer("log odds", correct = TRUE),
           answer("odds ratio")
  ),
  question("In a logistic regression the outcome variable can be ",
           answer("categorical", correct= TRUE),
           answer("continuous"),
           answer("both")
  )
)

how_to_use <- "In the next section we will demonstrate coding Logistic Regression in R. In it you will learn how to:"

intro_text <- "Willkommen, bienvenue, welcome to our app. In this diminutive digital diorama we hope to explain and explore Logistic Regression and use this method as a case study in the principles, perks and perils of data modelling. "

intro_two <- "Logistic regression is a statistical method that allows us to make sense 
              of binary data. That is, data that looks somewhat like this:"

intro_three <- "As this plot shows, linear correlation is not helpful for us here, 
                as we are not correlating our two classes of outcomes. Instead, we 
                want to use logistic regression to make inferences about new 
                data points and test the predictive power of our probabalistic 
                models."

logistic_intro_1 <- "For the purposes of this explanation we are going to, perhaps rather rudely, assume that you have some understanding of Linear Regression.  Logistic regression is similar to linear regression in that the model describes the relationship between one dependant or outcome variable and one or more independent or predictor variables. The big difference between a Linear and Logistic regression is that, whilst for linear regressions the outcome variable must be continuous, in the Logistic variation the outcome variable is dichotomous (a binary categorical distinction). For example:"
logistic_intro_2 <- "In logistic regression we examine the relationship between our predictor variables and the probability that an answer will be yes rather than no, right rather than wrong, covered in eels rather than not being covered in eels." 
logistic_intro_3 <- "The graph below shows the values of a single predictor variable plotted against the outcome of eels or no eels."

logistic_box_office <- "Within the context of our dataset we want our model to accurately predict if a nominated film falls into the Won or Lost categories. Let’s begin by imagining we have no predictors. If this were a linear regression, with a continuous outcome like Box Office profit, then our best guess would be the mean (which would for the intercept in a linear model). However, when our outcome is binary (0 or 1) then taking a mean (0.5) is useless because in the context of categorical ratings 0.5 doesn’t mean anything…. unless you’re LaLa Land. Instead the base prediction for logistic regression could be derived from the number of cases. The number of nominees for Best Picture changes periodically but for 2019 there were 8 contestants of whom only 1 wins. So for a logistic regression a more informative intercept might be that a film has a baseline 1 in 8 chance of winning.  However, this alone is neither very informative or very interesting, imagine betting on a race where all the horses have 1/8 odds. This is where our predictors come in. We want to use our data to build a model which expresses the relationship between our predictors and the films chance of winning." 

inf_pred_intro <- "Regression models serve two main purposes Inference and Prediction."
inference <- "Inference is the processes of evaluating the contribution of predictors to our outcomes. This allows us to ask questions like does budget matter? Do critic or audience scores matter more? Am I better of spending my money on CG moustache removal or bribing internet commentators?"
pred <- "Prediction is when we use our model to predict an outcome based on specific values of our predictor variables. This allows us to ask questions like, based on the IMBD and Rotten Tomatoes scores which film should I put my money on for the 2020 Best Pic? Or I spent this much removing moustaches and have bribed the internet to be this nice, what are my chances of winning?"
  

ui <- tagList(
  fluidPage(theme = shinytheme("cosmo")),
  navbarPage(
    # Title of Page
    "Logistic Regression",
    # First Tab
    tabPanel("Introduction",
             mainPanel(
               h2("Introduction to Logistic Regression"),
               p(intro_text),
               p(logistic_intro_1),
               tags$ul(
                 tags$li("Yes/No"),
                 tags$li("Correct/Wrong"),
                 tags$li("Dead/Alive"),
                 tags$li("Pregnant/Not-Pregnant"),
                 tags$li("Things-which-are-fine/Things-which-are-covered-in-eels")
               ),
               p(logistic_intro_2),
               p(logistic_intro_3),
               plotOutput("rawPlot"),
               p(intro_three)
             )
    ),
    # The Second Tab
    tabPanel("Learn About Logistic Regression",
         mainPanel(
           navlistPanel(
             "",
             tabPanel("Building an interactive model",
                      h2("Binary Logistic Regression"),
                      p(logistic_box_office),
                      fluidRow(
                        column(6,
                          sliderInput("logistic_n", "Number of Observations:", 0, 500, 100)
                        ),
                        column(6,
                          sliderInput("c1", "Coefficient (Predictive Power of Variable):", 0, 10, 3)
                        )
                      ),
                      plotOutput("logisticPlot"),
                      p("remember our raw data from before:"),
                      plotOutput("logisticRaw"),
                      h2("Multiple Logistic Regression"),
                      p("Although in the previous examples we have used just one predictor variable,  we can use multiple predictors and they can be a mixture of continuous and categorical. The graph below shows the influence on the probability of winning that 3 different factors have. "),
                      HTML('<img src="adamsandler.png" height="400"</img>'),
                      p("It should be noted that in this graph, we have normalized Budget, Score, and number of Adam Sandlers to fall between -3 and 3."),
                      p("As you can see, each of these lines create a distinct probability curve. Logstic regression can, in fact, use multiple predictors for one
                        binary outcome. You'll learn how to do this in the tutorial, but we won't visualize it here.")
             ),
             tabPanel("When Is This Appropriate?",
                      h2("Assumptions in Binary Logistic Regression"),
                      p("Logistic Regression is not the fussiest the methods It is fine with many kinds of data that linear regressions are not."),
                      p("What Binary Logistic Regression doesn’t require:"),
                      tags$ul(
                        tags$li("There does not need to be a linear relationship between the predictor and outcome variable."),
                        tags$li("The residuals (error terms) do not need to be normally distributed."),
                        tags$li("There is no assumption of homoscedasticity."),
                        tags$li("Predictors can be  continuous or categorical.")
                      ),
                      p("What Binary Logistic Regression does require:"),
                      tags$ul(
                        tags$li("That the outcome variable is a binary categorical outcome."),
                        tags$li("Observations should be independent of each other."),
                        tags$li("Little to no multicollinearity among the predictor variables. "),
                        tags$li("A linear relationship between the predictor variables and the log odds."),
                        tags$li("A reasonable sample size especially when one outcome is a lot less likely than the other.")
                      )
             ),
             tabPanel("Why Use Logistic Regression",
                      h2("Why Use This Technique?"),
                      p(inf_pred_intro),
                      p(inference),
                      p(pred)
             ),
             tabPanel("So how do I do it?",
                      h3("How do I implement a Logistic Regression Model?"),
                      p(how_to_use),
                      tags$ul(
                        tags$li("Generate appropriate data for Logistic Regression"),
                        tags$li("Create a logistic regression model"),
                        tags$li("Interpret the output of such a model, and"),
                        tags$li("Visualize logistic regression")
                      ),
                      p("After you're finished take our quiz to help see what you know and don't yet know about Logistic Regression Modles")
           )
         )
       )
    ),
    tabPanel("R Code Tutorials",
             htmlOutput("tutorial")
    ),
    tabPanel("Quiz",
           mainPanel(
             "Quick Logistic Regression Quiz",
             R_quiz
           )
    )
  )
)