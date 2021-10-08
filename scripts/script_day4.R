library(tidyverse)

weight_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/weight.csv")
nott_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/nottingham_temp.csv")


ggplot(weight_df,
       mapping = aes(x = weight)
) + geom_density(bw = 10)

ggplot(weight_df,
       mapping = aes(x = weight, colour = gender)
) + geom_density(bw = 10)

ggplot(weight_df,
       mapping = aes(x = weight, 
                     colour = gender, 
                     fill = gender)
) + geom_density(bw = 10)

ggplot(weight_df,
       mapping = aes(x = weight, 
                     colour = gender, 
                     fill = gender,
       )
) + geom_density(bw = 10, position = 'fill')

ggplot(weight_df,
       mapping = aes(x = weight, 
                     colour = gender, 
                     fill = gender,
                     )
) + geom_density(bw = 10, position = 'fill')

ggplot(weight_df,
       mapping = aes(x = weight, 
                     colour = gender, 
                     fill = gender,
       )
) + geom_density(bw = 10, position = 'dodge')

ggplot(weight_df,
       mapping = aes(x = weight, 
                     colour = gender, 
                     fill = gender,
       )
) + geom_density(bw = 10, position = 'stack')



# line plots --------------------------------------------------------------

ggplot(nott_df,
       mapping = aes(x = month, y = value)
) + geom_line()

ggplot(nott_df,
       mapping = aes(x = month, y = value)
) + geom_point()

ggplot(nott_df,
       mapping = aes(x = month, y = value, colour = factor(year))
) + geom_line()

ggplot(nott_df,
       mapping = aes(x = month, y = value, group = year)
) + geom_line()


# Plotting uncertainty ----------------------------------------------------

M <- lm(value ~ poly(month, 2), data = nott_df)

tmp_df <- tibble(month = seq(1, 12))
pred_df <- predict(M, newdata = tmp_df, interval = 'confidence')

nott_temp_pred <- bind_cols(tmp_df, as_tibble(pred_df))

ggplot(nott_temp_pred,
       mapping = aes(x = month, y = fit)
) + geom_line()

ggplot(nott_temp_pred,
       mapping = aes(x = month, y = fit, ymax = upr, ymin = lwr)
) + geom_pointrange()

ggplot(nott_temp_pred,
       mapping = aes(x = month, y = fit, ymax = upr, ymin = lwr)
) + geom_pointrange() + geom_line()

ggplot(nott_temp_pred,
       mapping = aes(x = month, y = fit, ymax = upr, ymin = lwr)
) + geom_linerange() + geom_line()

ggplot(nott_temp_pred,
       mapping = aes(x = month, y = fit, ymax = upr, ymin = lwr)
) + geom_ribbon(alpha = 0.4) + geom_line()

ggplot(nott_temp_pred,
       mapping = aes(x = month)
) + 
  geom_line(aes(y = fit)) + 
  geom_line(aes(y = upr), colour = 'red') +
  geom_line(aes(y = lwr), colour = 'blue')


# heatmaps ----------------------------------------------------------------

ggplot(nott_df,
       aes(x = year, y = month, fill = value)
) + geom_tile() +
  scale_fill_gradient(low = 'yellow', high = 'red')



map_data <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/local_authority_map_data.csv")


eu_data <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/EU-referendum-result-data.csv")

ggplot(map_data,
       mapping = aes(x = long, y = lat, group = group)
) + geom_polygon(colour = 'white', size = 0.1, fill = 'grey50') +
  coord_equal()


inner_join(map_data, eu_data, by = c('id' = 'Area_Code')) %>% 
  ggplot(mapping = aes(x = long, y = lat, group = group, fill = Pct_Leave)
  ) + geom_polygon(colour = 'white', size = 0.1) +
  coord_equal() +
  scale_fill_gradient(low = 'yellow', high = 'red')



# Fine tuning -------------------------------------------------------------

p10 <- ggplot(weight_df,
              mapping = aes(x = height, y = weight, colour = gender)
) + geom_point()

p10 + theme_classic()
p10 + theme_minimal()
p10 + theme_bw()
p10 + theme_dark()
p10 + theme_gray()
p10 + theme_light()

library(ggthemes)

p10 + theme_economist()
p10 + theme_fivethirtyeight()
p10 + theme_wsj()
p10 + theme_excel()
p10 + theme_excel_new()
p10 + theme_economist_white()
p10 + theme_stata()
p10 + theme_tufte()


# set the default theme for all subsequent plots
theme_set(theme_classic())

p10 # this uses theme_classic now


# change the labels
p10 + xlab("The height of US Army personnel") +
  ylab("Weight in Kg")

p10 + labs(x = 'Height in cm', y = 'Weight in Kg')

p10 + ggtitle("The weight of people against their height")


# https://ggplot2.tidyverse.org/reference/theme.html

p10 + theme(legend.position = 'bottom')
p10 + theme(legend.position = 'top')
p10 + theme(legend.position = 'left')
p10 + theme(legend.position = 'right')
p10 + theme(legend.position = 'none')

p10 + theme(legend.position = 'bottom',
            legend.title  = element_text(size = 25, 
                                         colour = 'red',
                                         angle = 90),
            legend.text = element_text(size = 5),
            axis.title.x = element_text(colour = 'blue', 
                                        face = 'italic',
                                        size = 50),
            axis.ticks.x = element_blank(),
            axis.text.x = element_text(size = 25)
)

p10 + scale_x_continuous(breaks = c(140, 150, 190, 200))
p10 + scale_y_continuous(breaks = c(60, 70, 80))

p10 + xlim(100, 300)
p10 + ylim(70, 100)
p10 + lims(x = c(100, 200), y = c(70, 100))


p11 <- ggplot(weight_df,
              aes(x = gender, y = weight)
) + geom_boxplot()


p11 + scale_x_discrete(labels = c('Female' = 'Women',
                                  'Male' = 'Men')
)

p10 + scale_colour_manual(values = c('green',
                                     'blue'))

ggplot(weight_df,
              aes(x = weight, fill = gender)
) + geom_density() + 
  scale_fill_manual(values = c('green', 'blue'))

diamonds_df <- sample_frac(diamonds, size = 0.1)

p12 <- ggplot(
  diamonds_df,
       mapping = aes(x = carat, 
                     y = price,
                     colour = cut)
) + geom_point()

# 
p12 + scale_color_brewer(palette = 'Set1')
p12 + scale_color_brewer(palette = 'Set2')
p12 + scale_color_brewer(palette = 'Set3')

# sequential palettes
p12 + scale_color_brewer(palette = 'Oranges')

# Colour blind option
p12 + scale_colour_colorblind()

# default?
p12 + scale_colour_viridis_d(option = 'inferno')
