# Predict diamond price - ShinyApp - server engine (server.R)
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# author: Marko Intihar


# load essential libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Define server logic required to create prediction model, draw plot & make price prediction
shinyServer(function(input, output) {

    # Build model for diamond price prediction 
    model <- lm(price ~ carat + color + cut, data = diamonds)
    
    # Predict diamond price using diamond features (provided by user)
    modelpred <- reactive({
        # input diamond features
        caratInput <- input$carat_user
        colorInput <- input$color_user
        cutInput   <- input$cut_user
        
        # model prediction (diamond price)
        predict(model, newdata = data.frame(carat = caratInput,
                                            color = colorInput,
                                            cut = cutInput))
    })
    
    # Predicted price (numeric value) - rounded on 100 USD
    # output$pred <- renderText({
    #     round(modelpred() / 100, 0) * 100
    # })
    
    # Predicted price as string (added USD)
    output$pred_USD <- renderText({
        paste(round(modelpred() / 100, 0) * 100, "USD", sep = " ")
    })
    
    # Diamonds prices plot (diamonds data set) & predicted diamond price (based on user inputs)
    output$plot <- renderPlot({
        
        # select number of diamonds (for the plot) based on user input
        df <- diamonds %>% 
            sample_n(size = input$nr_diamonds, replace = F)
        
        # data frame for predicted price and diamond features (user inputs)
        df.pred <- data.frame(price = modelpred(),
                              carat = input$carat_user,
                              color = input$color_user,
                              cut = input$cut_user)
        
        # create diamonds price scatter plot (actual diamonds & predicted diamond price)
        df %>% 
            ggplot(aes(x = carat, 
                       y = price,
                       color = color,
                       shape = cut)) +
            geom_point(size = 3) +
            geom_point(data = df.pred,
                       aes(x = carat, y = price),
                       color = "brown1",
                       size = 10) +
            annotate(geom = "text", x = df.pred$carat, y = df.pred$price + 2000,
                     label = "Your diamond!",
                     color = "brown1",
                     size = 7, face = "bold") +
            scale_color_grey() +
            xlab("Diamond weight in carats") +
            ylab("Diamond price in USD") +
            ggtitle("Diamond prices (actual diamonds & your diamond's price prediction)") +
            theme(plot.title = element_text(size = 24),
                  axis.title = element_text(size = 20),
                  axis.text = element_text(size = 16),
                  legend.title = element_text(size = 16),
                  legend.text = element_text(size = 14))
            })

})
