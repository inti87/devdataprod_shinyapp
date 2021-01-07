#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Diamond price (prediction)"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("nr_diamonds",
                        "How many diamonds (from the data) should be plotted?",
                        min = 0,
                        max = 50000,
                        value = 10000),
            sliderInput("carat_user",
                        "What is your diamond weight (in carat)?",
                        min = 0,
                        max = 5,
                        value = 2.5,
                        step = 0.01),
            radioButtons("color_user",
                         "What is your diamond color (from J (worst) to D (best))?",
                         choices = c("D" = "D",
                                     "E" = "E",
                                     "F" = "F",
                                     "G" = "G",
                                     "H" = "H",
                                     "I" = "I",
                                     "J" = "J"), 
                         selected = "G"),
            radioButtons("cut_user",
                         "What is your diamond cut?",
                         choices = c("Ideal" = "Ideal",
                                     "Premium" = "Premium",
                                     "Very Good" = "Very Good",
                                     "Good" = "Good",
                                     "Fair" = "Fair"),
                         selected = "Very Good")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot", width = "100%"),
            h3("Predicted diamond price in USD from lm model:"),
            textOutput("pred")
        )
    )
))
