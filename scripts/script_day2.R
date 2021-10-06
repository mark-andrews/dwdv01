
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

pivot_longer(repeated_df_b,
             -Subject,
             names_to = 'condition',
             values_to = 'recall') %>% 
  separate(condition, into = c('cue', 'emotion'), sep = '_')

pivot_longer(repeated_df_b,
             -Subject,
             names_to = c('cue', 'emotion'),
             names_sep = '_',
             values_to = 'recall')

pivot_longer(repeated_df_b,
             -Subject,
             names_to = c('cue', 'emotion'),
             names_sep = '_',
             values_to = 'recall') %>% 
  select(Subject, emotion, cue, recall) %>% 
  arrange(Subject, emotion)

pivot_longer(repeated_df_b,
             -Subject,
             names_to = c('cue', 'emotion'),
             names_pattern = '(Cued|Free)_(Neg|Neu|Pos)',
             values_to = 'recall')


blp_df_desc <- summarise(blp_df,
          across(rt:rt.raw,
                 list(avg = ~mean(., na.rm = T),
                      sd = ~sd(., na.rm = T))
          )
)


pivot_longer(blp_df_desc,
             everything(),
             names_to = 'var_summary',
             values_to = 'descriptive') %>% 
  separate(var_summary, into = c('variable', 'summary'), sep = '_') %>% 
  pivot_wider(names_from = summary,
              values_from = descriptive)


pivot_longer(blp_df_desc,
             everything(),
             names_to = c('variable', '.value'),
             names_sep = '_')


# Combining data frames by stacking and by joining ------------------------

Df_1 <- tibble(x = c(1, 2, 3),
               y = c(2, 7, 1),
               z = c(0, 2, 7))

Df_2 <- tibble(y = c(5, 7),
               z = c(6, 7),
               x = c(1, 2))

Df_3 <- tibble(a = c(5, 6, 1),
               b = c('a', 'b', 'c'),
               c = c(T, T, F))

Df_a <- tibble(x = c(1, 2, 3),
               y = c('a', 'b', 'c'))

Df_b <- tibble(x = c(2, 3, 4),
               z = c('d', 'e', 'f'))

Df_4 <- tibble(x = c(1, 2, 3),
               y = c(2, 7, 1),
               z = c(0, 2, 7))

Df_5 <- tibble(a = c(1, 1, 7),
               b = c(2, 3, 7),
               c = c('a', 'b', 'c'))

Df_6 <- tibble(x = c(1, 2, 3),
               y = c(4, 5, 6),
               z = c(7, 8, 9))

Df_7 <- tibble(y = c(6, 7),
               z = c(9, 10),
               x = c(3, 4))

bind_rows(Df_1, Df_2)
bind_rows(Df_2, Df_1)
bind_cols(Df_1, Df_3)
bind_rows(Df_1, Df_3)

Df_a
Df_b

inner_join(Df_a, Df_b)
left_join(Df_a, Df_b)
right_join(Df_a, Df_b)
full_join(Df_a, Df_b)

blp_stimuli <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/blp_stimuli.csv")

inner_join(blp_df, blp_stimuli)
filter(blp_stimuli, spell == 'staud')

left_join(blp_df, blp_stimuli)
right_join(blp_df, blp_stimuli)

Df_4
Df_5
inner_join(Df_4, Df_5)
inner_join(Df_4, Df_5, by = c('x' = 'a'))
inner_join(Df_4, rename(Df_5, 'x' = 'a'))


# Read in multiple files into one data frame ------------------------------


list.files('exp_data', full.names = TRUE)

library(fs)
data_file_list <- dir_ls('exp_data')

data_frame_list <- map(data_file_list, read_csv)
length(data_frame_list)
names(data_frame_list)

#map(data_file_list, read_csv) %>% bind_rows()

exp_data_df <- bind_rows(data_frame_list)
class(exp_data_df)
dim(exp_data_df)

exp_data_df <- bind_rows(data_frame_list, .id = 'subject')
exp_data_df %>% 
  mutate(subject = str_match(subject, 'exp_data/subject-(.*)\\.csv')[,2])

# pipeline version of the above
dir_ls('exp_data') %>% 
  map(read_csv) %>% 
  bind_rows(.id = 'subject') %>% 
  mutate(subject = str_match(subject, 
                             'exp_data/subject-(.*)\\.csv')[,2]
  )

# another pipeline version of the above
dir_ls('exp_data') %>% 
  map_dfr(read_csv, .id = 'subject') %>% 
  mutate(subject = str_match(subject, 
                             'exp_data/subject-(.*)\\.csv')[,2]
  )

exp_data_df <- bind_rows(data_frame_list, .id = 'subject')
exp_data_df %>% select(1) %>% 
  mutate(subject = str_match(subject, 'exp_data/subject-(.*)\\.csv'))
