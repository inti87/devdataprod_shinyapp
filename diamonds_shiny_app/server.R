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

    # Build model for diamond price prediction 
    model <- lm(price ~ carat + color + cut, data = diamonds)
    
    # Predict diamond price using diamond features (provided by user)
    modelpred <- reactive({
        caratInput <- input$carat_user
        colorInput <- input$color_user
        cutInput   <- input$cut_user
        
        predict(model, newdata = data.frame(carat = caratInput,
                                            color = colorInput,
                                            cut = cutInput))
    })
    
    # Predicted price (numeric value)
    output$pred <- renderText({
        modelpred()
    })
    
    # Diamonds prices plot (diamonds data set) & predicted value (based on user input)
    output$plot <- renderPlot({
        
        # select number of diamonds based on input$nr_diamonds from ui.R
        df <- diamonds %>% 
            sample_n(size = input$nr_diamonds, replace = F)
        
        # data frame for predicted price and diamond features (user input)
        df.pred <- data.frame(price = modelpred(),
                              carat = input$carat_user,
                              color = input$color_user,
                              cut = input$cut_user)
        
        # draw diamonds price scatter plot 
        df %>% 
            ggplot(aes(x = carat, 
                       y = price,
                       color = color,
                       shape = cut)) +
            geom_point(size = 3) +
            geom_point(data = df.pred,
                       aes(x = carat, y = price),
                       color = "brown",
                       size = 10) +
            annotate(geom = "text", x = df.pred$carat, y = df.pred$price + 2000,
                     label = "Your diamond price!",
                     color = "brown",
                     size = 7, face = "bold") +
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
