# Predict diamond price - ShinyApp - user-interface (ui.R)
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# author: Marko Intihar


# load libraries
library(shiny) 

# Define UI for application that builds a diamond price prediction model & 
# creates diamonds plot and predicts users's diamond price
shinyUI(fluidPage(

    # Application title
    titlePanel("Diamond price (prediction)"),

    # Sidebar with sliders & radio buttons (for user input data - diamond features)
    sidebarLayout(
        sidebarPanel(
            
            # user input - control how many diamonds are plotted (from diamonds data set - ggplot2)
            sliderInput("nr_diamonds",
                        "How many diamonds (from the data) should be plotted?",
                        min = 0,
                        max = 50000,
                        value = 10000),
            
            # user input - weight of selected diamond (from the user) in carats
            sliderInput("carat_user",
                        "What is your diamond's weight (in carats)?",
                        min = 0,
                        max = 5,
                        value = 2.5,
                        step = 0.01),
            
            # user input - color of selected diamond (from the user) - color options given
            radioButtons("color_user",
                         "What is your diamond's color (from J (worst) to D (best))?",
                         choices = c("D  (best color)" = "D",
                                     "E" = "E",
                                     "F" = "F",
                                     "G" = "G",
                                     "H" = "H",
                                     "I" = "I",
                                     "J (worst color)" = "J"), 
                         selected = "G"),
            
            # user input - cut of selected diamond (from the user) - cut options given
            radioButtons("cut_user",
                         "What is your diamond cut?",
                         choices = c("Ideal" = "Ideal",
                                     "Premium" = "Premium",
                                     "Very Good" = "Very Good",
                                     "Good" = "Good",
                                     "Fair" = "Fair"),
                         selected = "Very Good"),
            
            # master submit button - to run server calculations when inputs are defined
            submitButton("Submit")
            
        ),

        # Show a plot of diamond prices (actual diamonds & user's diamond's price prediction) &
        # show predicted diamond price in USD (in numeric form)
        mainPanel(
            plotOutput("plot", width = "100%"),
            h3("Your diamond's predicted price (in USD) from simple linear model:"),
            textOutput("pred_USD"),
            # CSS styling for price prediction (shown as text)
            tags$head(tags$style("#pred_USD{color: red;
                                 font-size: 40px;
                                 font-style: bold;
                                 }"))
        )
    )
))
