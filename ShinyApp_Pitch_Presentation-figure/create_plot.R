library(ggplot2)
library(dplyr)

# data frame for predicted price and diamond features (user inputs)
df.pred <- data.frame(price = 15917,
                      carat = 2.5,
                      color = "J",
                      cut = "Good")

# create diamonds price scatter plot (actual diamonds & predicted diamond price)
diamonds %>% 
  sample_n(size = 10000, replace = F) %>% 
  ggplot(aes(x = carat, 
             y = price,
             color = color,
             shape = cut)) +
  geom_point(size = 1, show.legend = F) +
  geom_point(data = df.pred,
             aes(x = carat, y = price),
             color = "brown1",
             size = 5) +
  annotate(geom = "text", x = df.pred$carat, y = df.pred$price + 2000,
           label = "Your diamond!",
           color = "brown1",
           size = 4, face = "bold") +
  scale_color_grey() +
  xlab("Diamond weight in carats") +
  ylab("Diamond price in USD") +
  ggtitle("Diamond prices") +
  theme(plot.title = element_text(size = 12),
        axis.title = element_text(size = 10),
        axis.text = element_text(size = 8),
        legend.title = element_text(size = 8),
        legend.text = element_text(size = 7))

ggsave(filename = "./ShinyApp_Pitch_Presentation-figure/diamondplot.png",
       plot = last_plot(), units = "cm", width = 12, height = 8)
