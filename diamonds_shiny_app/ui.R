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
                        value = 10000)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot", width = "100%")
        )
    )
))
