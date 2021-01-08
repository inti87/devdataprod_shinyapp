# ShinyApp Documentation

### App name: Diamond price prediction
### App author: Marko Intihar
### Date created: 2021-01-08


## App's basic idea

ShinyApp can be used as a helper to estimate (or predict) diamond price by providing  diamond features. ShinyApp also shows actual diamonds' prices plot (with selected diamonds' features). 


## Data Used

To build diamond price prediction model and to show actual diamond prices the ShinyApp uses diamonds data set from the **ggplot2** library. Only given diamond features are used in
the model and shown on provided plot:

* **diamond weight**
* **diamond color**
* **diamond cut**
* **diamond price** (also used as predicted variable)



## How to use app

On the sidebar panel (left side of the ShinyApp) user selects:

* Number of actual diamonds to be shown on the plot (diamonds are randomly selected) - slider button
* **User's diamond's weight** in carat (diamond feature) - slider button
* **User's diamond's color** (diamond feature) - radio button (all options given)
* **User's diamond's cut** (diamond feature) - radio button (all options given)
* **Submit button** - to run server calculations and build the output



## App output

When user hits the **Submit button**, shiny server will run ShinyApp calculations:

* simple linear prediction model is built using all diamonds from the diamonds data set 
* model only includes features, that user can selects using main panel 

The results of calculations are given on main panel (right side of the ShinyApp):

* scatter plot is drawn showing diamond features and diamond prices
* actual diamonds prices are shown and diamond with selected features by user with predicted price by linear model
* also predicted diamond price is shown below (price is given in USD and the value is rounded to 100USD)

