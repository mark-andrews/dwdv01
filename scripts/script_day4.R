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


inner_join(map_data, eu_data, by = c('id' = 'Area_Code'))
