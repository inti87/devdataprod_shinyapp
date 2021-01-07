#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$plot <- renderPlot({
        
        # select number of diamonds based on input$nr_diamonds from ui.R
        df <- diamonds %>% 
            sample_n(size = input$nr_diamonds, replace = F)
        
        # draw diamonds price scatter plot 
        df %>% 
            ggplot(aes(x = carat, 
                       y = price,
                       color = color,
                       shape = cut)) +
            geom_point(size = 3) +
            xlab("Diamond weight in carats") +
            ylab("Diamond price in USD") +
            ggtitle("Diamond prices") +
            theme(plot.title = element_text(size = 24),
                  axis.title = element_text(size = 20),
                  axis.text = element_text(size = 16),
                  legend.title = element_text(size = 16),
                  legend.text = element_text(size = 14))
            
        
    })

})
