library(tidyverse)

data_df <- tibble(var1 = c(1, 3, 7, 11),
                  var2 = c(5, 7, 10, 12),
                  var3 = c('a', 'b', 'a', 'b')
)

ggplot(data_df,
       mapping = aes(x = var1, y = var2)
) + geom_point()

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
