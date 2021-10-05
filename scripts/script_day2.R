
# summarizing with summarize ----------------------------------------------

library(tidyverse)

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/blp-trials-short.txt")
  
summarize(blp_df, med_rt = median(rt, na.rm = T))

summarise(blp_df, 
          med_rt = median(rt, na.rm = T),
          sd_rt = sd(rt, na.rm = T),
          mean_prev = mean(prev.rt, na.rm = T),
          mad_raw = mad(rt.raw, na.rm = T)
)

summarize(blp_df,
          across(rt:rt.raw, ~mean(., na.rm=T))
)

summarise(blp_df,
          across(rt:rt.raw,
                 list(avg = ~mean(., na.rm = T),
                      sd = ~sd(., na.rm = T))
          )
)

group_by(blp_df, lex) %>% 
  summarize(avg_rt = mean(rt, na.rm = T),
            sd_rt = sd(rt.raw, na.rm = T)
  )


group_by(blp_df, participant) %>% 
  summarize(avg_rt = mean(rt, na.rm = T),
            sd_rt = sd(rt.raw, na.rm = T)
  )

group_by(blp_df, lex, resp) %>% 
  summarize(avg_rt = mean(rt, na.rm = T),
            sd_rt = sd(rt.raw, na.rm = T)
  )


# Going from long to wide, or wide to long with pivots --------------------

repeated_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/repeated_measured_a.csv")

pivot_longer(repeated_df,
             -Subject,
             names_to = 'condition',
             values_to = 'score')

repeated_df_wide <- pivot_longer(repeated_df,
                                 -Subject,
                                 names_to = 'condition',
                                 values_to = 'score')

pivot_wider(repeated_df_wide,
            names_from = condition,
            values_from = score)

repeated_df_b <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/repeated_measured_b.csv")
