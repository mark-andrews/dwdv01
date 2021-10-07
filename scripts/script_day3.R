library(tidyverse)

data_df <- tibble(var1 = c(1, 3, 7, 11),
                  var2 = c(5, 7, 10, 12),
                  var3 = c('a', 'b', 'a', 'b')
)

ggplot(data_df,
       mapping = aes(x = var1, y = var2)
) + geom_point()

ggplot(data_df,
       aes(var1, var2)
) + geom_point()

p1 <- ggplot(data_df,
       aes(var1, var2)
)

p2 <- p1 + geom_point()
p3 <- p1 + geom_line()

ggplot(data_df,
       mapping = aes(x = var1, y = var2)
) + geom_line()

ggplot(data_df,
       mapping = aes(x = var1, y = var2)
) + geom_line() + geom_point()


ggplot(data_df,
       mapping = aes(x = var1, y = var2, colour = var3)
) + geom_point()

ggplot(data_df,
       mapping = aes(x = var1, y = var2, colour = var3)
) + geom_line()


ggplot(data_df,
       mapping = aes(x = var1, y = var2, shape = var3)
) + geom_point()

ggplot(data_df,
       mapping = aes(x = var1, y = var2, shape = var3)
) + geom_line()

ggplot(data_df,
       mapping = aes(x = var1, y = var2, group = var3)
) + geom_line()


ggplot(data_df,
       mapping = aes(x = var1, y = var2, linetype = var3)
) + geom_line()

# the linetype does nothing here (at least visually)
ggplot(data_df,
       mapping = aes(x = var1, y = var2, linetype = var3)
) + geom_point()
ggplot(data_df,
       mapping = aes(x = var1, y = var2, group = var3)
) + geom_point()

ggplot(data_df,
       mapping = aes(x = var1, y = var2)
) + geom_point(size = 2.5, colour = 'red')


# Get some data -----------------------------------------------------------

weight_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/weight.csv")
titanic_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/TitanicSurvival.csv")
carprice_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/carprice.csv")
sleep_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/sleepstudy.csv")


# histogram ---------------------------------------------------------------

ggplot(weight_df,
       mapping = aes(x = weight)
) + geom_histogram(binwidth = 2,
                   colour = 'white',
                   fill = 'orchid1')

ggplot(weight_df,
       mapping = aes(x = weight, fill = gender)
) + geom_histogram(binwidth = 2,
                   colour = 'white')
# equiv to position = 'stack'

ggplot(weight_df,
       mapping = aes(x = weight, fill = gender)
) + geom_histogram(binwidth = 2,
                   colour = 'white',
                   position = 'dodge')

ggplot(weight_df,
       mapping = aes(x = weight, fill = gender)
) + geom_histogram(binwidth = 2,
                   colour = 'white',
                   position = 'identity',
                   alpha = 0.75)

ggplot(weight_df,
       mapping = aes(x = weight, fill = gender)
) + geom_histogram(binwidth = 2,
                   colour = 'white',
                   position = 'fill')

ggplot(titanic_df,
       mapping = aes(x = survived)
) + geom_bar()

ggplot(titanic_df,
       mapping = aes(x = survived, fill = sex)
) + geom_bar()

ggplot(titanic_df,
       mapping = aes(x = survived, fill = sex)
) + geom_bar(position = 'stack')

ggplot(titanic_df,
       mapping = aes(x = survived, fill = sex)
) + geom_bar(position = 'dodge')

ggplot(titanic_df,
       mapping = aes(x = survived, fill = sex)
) + geom_bar(position = 'identity',
             alpha = 0.75)

ggplot(titanic_df,
       mapping = aes(x = survived, fill = sex)
) + geom_bar(position = 'fill')


carprice_df

ggplot(carprice_df,
       mapping = aes(x = Type)
) + geom_bar()

carprice_df %>% 
  group_by(Type) %>% 
  summarise(price = mean(Price)) %>% 
  ggplot(mapping = aes(x = Type, y = price)) +
  geom_bar(stat = 'identity')

carprice_df %>% 
  group_by(Type) %>% 
  summarise(price = mean(Price)) %>% 
  ggplot(mapping = aes(x = Type, y = price)) +
  geom_col()


# Tukey boxplot -----------------------------------------------------------

ggplot(swiss,
       mapping = aes(x = '', y = Fertility)
) + geom_boxplot(width = 0.2)

ggplot(swiss,
       mapping = aes(x = '', y = Fertility)
) + geom_boxplot(width = 0.2) +
  geom_point()

ggplot(swiss,
       mapping = aes(x = '', y = Fertility)
) + geom_boxplot(width = 0.2) +
  geom_point() +
  geom_jitter()

ggplot(swiss,
       mapping = aes(x = '', y = Fertility)
) + geom_boxplot(width = 0.2) +
  geom_jitter(width = 0.05,colour = 'red')

ggplot(swiss,
       mapping = aes(x = '', y = Fertility)
) + geom_boxplot(width = 0.2, outlier.shape = NA) +
  geom_jitter(width = 0.05)

# One option to not show jittered outliers
quantiles <- swiss %>% pull(Fertility) %>%
  quantile(probs = c(lwr = 0.25, median = 0.5, upr = 0.75)) %>% 
  set_names(c('lwr', 'median', 'upr'))

swiss %>% mutate(q = list(quantiles)) %>% 
  select(Fertility, q) %>% 
  unnest_wider(q) %>% 
  mutate(upr_limit = upr + 1.5*(upr - lwr),
         lwr_limit = lwr - 1.5*(upr - lwr),
         outlier = na_if(Fertility > upr_limit | Fertility < lwr_limit, TRUE)) %>% 
  ggplot(aes(x = '', y = Fertility)) +
  geom_boxplot(width = 0.25) +
  geom_jitter(aes(shape = outlier), width = 0.05) +
  theme(legend.position = 'none')



swiss %>% 
  mutate(catholic = Catholic > 50) %>% 
  ggplot(aes(x = catholic, y = Fertility)) +
  geom_boxplot(width = 0.5, outlier.shape = NA) +
  geom_jitter(width = 0.2)

ToothGrowth

# this does not make what we want
ggplot(ToothGrowth,
       mapping = aes(x = dose, y = len, colour = supp)
) + geom_boxplot()

# here's a way of getting close to what we want
ggplot(ToothGrowth,
       mapping = aes(x = factor(dose), y = len, colour = supp)
) + geom_boxplot()

# here's another way of getting close to what we want
ggplot(ToothGrowth,
       mapping = aes(x = dose, y = len, colour = supp, group = dose)
) + geom_boxplot()

# here's another way of getting close to what we want
ggplot(ToothGrowth,
       mapping = aes(x = dose, 
                     y = len, 
                     colour = supp, 
                     group = interaction(supp, dose))
) + geom_boxplot()

ggplot(ToothGrowth,
       mapping = aes(x = dose, 
                     y = len, 
                     colour = supp, 
                     group = interaction(dose, supp))
) + geom_boxplot()

ggplot(ToothGrowth,
       mapping = aes(x = dose, 
                     y = len, 
                     colour = supp, 
                     group = interaction(dose, supp))
) + geom_boxplot() +
  geom_jitter(width = 0.05)

ggplot(ToothGrowth,
       mapping = aes(x = dose, 
                     y = len, 
                     colour = supp, 
                     group = interaction(dose, supp))
) + geom_boxplot() +
  geom_jitter(
    position = position_jitterdodge(
      dodge.width = 1/3,
      jitter.width = 1/3 * 0.5
  )
)


# scatterplot -------------------------------------------------------------

ggplot(weight_df,
       mapping = aes(x = height, y = weight)
) + geom_point(alpha = 0.5, size = 0.5)



ggplot(weight_df,
       mapping = aes(x = height, y = weight, colour = gender)
) + geom_point()

ggplot(weight_df,
       mapping = aes(x = height, y = weight)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth(method = 'lm')


ggplot(weight_df,
       mapping = aes(x = height, y = weight)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth(method = 'lm', 
              colour = 'black',
              se = FALSE)

ggplot(weight_df,
       mapping = aes(x = height, y = weight, colour = gender)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth(method = 'lm',
              se = FALSE)

ggplot(weight_df,
       mapping = aes(x = height, y = weight, colour = gender)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth(method = 'lm',
              fullrange = TRUE,
              se = FALSE)

ggplot(weight_df,
       mapping = aes(x = height, y = weight)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth()

ggplot(swiss,
       mapping = aes(x = Examination, y = Fertility)
) + geom_point() + stat_smooth(se = FALSE)

ggplot(weight_df,
       mapping = aes(x = height, y = weight)
) + geom_point(size = 0.5, alpha = 0.5) +
  stat_smooth(method = 'loess')


ggplot(swiss,
       mapping = aes(x = Examination, y = Fertility)
) + geom_point() + stat_smooth(se = T, 
                               method = 'gam',
                               formula = y ~ s(x, bs = "tp"))


ggplot(swiss,
       mapping = aes(x = Examination, y = Fertility)
) + geom_point() + stat_smooth(se = T, 
                               method = 'lm',
                               formula = y ~ poly(x, 3))


ggplot(swiss,
       mapping = aes(x = Examination, y = Fertility)
) + geom_point() + stat_smooth(se = T, 
                               #method = 'lm',
                               formula = y ~ x)


# facet plots -------------------------------------------------------------

ggplot(sleep_df,
       mapping = aes(x = Days, y = Reaction)
) + geom_point()

ggplot(sleep_df,
       mapping = aes(x = Days, y = Reaction, colour = Subject)
) + geom_point()

ggplot(sleep_df,
       mapping = aes(x = Days, y = Reaction, colour = Subject)
) + geom_point() + stat_smooth(method = 'lm')

ggplot(sleep_df,
       mapping = aes(x = Days, y = Reaction, colour = Subject)
) + geom_point() + stat_smooth(method = 'lm', se = F)

ggplot(sleep_df,
       mapping = aes(x = Days, y = Reaction, colour = Subject)
) + geom_point() + stat_smooth(method = 'lm', se = F) +
  facet_wrap(~Subject)
