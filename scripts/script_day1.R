library(tidyverse)

# Get some data -----------------------------------------------------------

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/blp-trials-short.txt")


# Wrangling ---------------------------------------------------------------

# verbs

# select
# relocate
# rename
# slice
# filter
# mutate
# arrange

select(blp_df, participant, lex, resp, rt)
select(blp_df, participant, lex, resp, reaction_time = rt)

select(blp_df, 1, 5, 2)

select(blp_df, lex:rt)
select(blp_df, 1:5)


select(blp_df, participant, resp:prev.rt, 2)


select(blp_df, starts_with('r'))
select(blp_df, ends_with('t'))
select(blp_df, contains('rt'))

select(blp_df, matches('^rt'))
select(blp_df, starts_with('rt'))
select(blp_df, matches('rt$'))
select(blp_df, ends_with('rt'))
select(blp_df, matches('^rt|rt$'))

select(blp_df, participant)
select(blp_df, -participant)
select(blp_df, -starts_with('r'))


# select all the numeric variables
select(blp_df, where(is.numeric))

# re-order variables
select(blp_df, rt, lex, everything())

relocate(blp_df, rt, lex)

relocate(blp_df, rt, .after = lex)
relocate(blp_df, rt)
relocate(blp_df, rt, .before = lex)
relocate(blp_df, rt, .after = last_col())



# renaming with rename ----------------------------------------------------

select(blp_df, reaction_time = rt)
select(blp_df, reaction_time = rt, everything())

rename(blp_df, reaction_time = rt)
rename(blp_df, lexical = lex, reaction_time = rt)

rename_with(blp_df, toupper)

rename_with(blp_df, 
            ~str_replace(., 'rt', 'reaction_time'),
            matches('^rt|rt$'))


# slice rows by index -----------------------------------------------------

slice(blp_df, 10:20)
blp_df[10:20,]
slice(blp_df, 3, 5, 10, 20)
slice(blp_df, 3, 5, 10:15)
slice(blp_df, -1)
slice(blp_df, 1:10)
slice(blp_df, n())
slice(blp_df, (n()-9):n())

# filtering rows with filter
filter(blp_df, lex == 'W')
filter(blp_df, lex == 'W', resp == 'W')
filter(blp_df, rt < 500)
filter(blp_df, rt < 500 & resp == 'W')
filter(blp_df, rt < 500, resp == 'W')
filter(blp_df, rt < 500 | resp == 'W') # rt < 500 OR resp == 'W'
filter(blp_df, !(rt < 500) | resp == 'W' & lex == 'W')

filter(blp_df, if_any(rt:rt.raw, ~ . < 500))
filter(blp_df, if_all(rt:rt.raw, ~ . < 500))

filter(blp_df, if_all(rt:rt.raw, ~ . < median(., na.rm = T)))
filter(blp_df, if_all(where(is.numeric),
                      ~ . < median(., na.rm = T)))


# create new variables with mutate ----------------------------------------

mutate(blp_df, accuracy = lex == resp)

mutate(blp_df, 
       accuracy = lex == resp,
       word_length = str_length(spell)
)

mutate(blp_df, lex == resp)

mutate(blp_df, lex = as.factor(lex))

mutate(blp_df,
       lex = as.factor(lex),
       spell = as.factor(spell),
       resp = as.factor(resp)
)

mutate(blp_df,
       across(where(is.character), as.factor)
)


mutate(blp_df,
       across(lex:resp, as.factor)
)

mutate(blp_df,
       across(c(lex, spell, resp), as.factor)
)


mutate(blp_df,
       across(where(is.numeric), ~as.vector(scale(.)))
)

# this: ~as.vector(scale(.))
# is like this
re_scale <- function(x){
  as.vector(scale(x))
}

mutate(blp_df,
       across(where(is.numeric), re_scale)
)

mutate(blp_df,
       across(where(is.numeric), function(x){as.vector(scale(x))})
)

mutate(blp_df,
       across(where(is.numeric), ~as.vector(scale(.)))
)


mutate(blp_df,
       lex = recode(lex, 'W' = 'word', 'N' = 'nonword')
)

mutate(blp_df,
       lex = recode(lex, 'W' = 'word', 'N' = 'nonword'),
       resp = recode(resp, 'W' = 'word', 'N' = 'nonword')
)

mutate(blp_df,
       across(c(lex, resp),
              ~recode(., 'W' = 'word', 'N' = 'nonword')
       )
)

my_recoding_f <- function(x){
  recode(x, 'W' = 'word', 'N' = 'nonword')
}

mutate(blp_df,
       across(c(lex, resp), my_recoding_f)
)

mutate(blp_df,
       rt_speed = if_else(rt > 900, 'slow', 'fast')
)

mutate(blp_df,
       rt_speed = case_when(
         rt > 900 ~ "slow",
         rt < 600 ~ "fast",
         TRUE ~ "medium"
       )
)
mutate(blp_df, 
       accuracy = lex == resp) %>% select(-c(lex, resp))

mutate(blp_df, 
       accuracy = lex == resp,
       word_length = str_length(spell)
)

transmute(blp_df, 
       accuracy = lex == resp,
       word_length = str_length(spell)
)


# sorting with arrange ----------------------------------------------------

arrange(blp_df, rt)
arrange(blp_df, desc(rt))
arrange(blp_df, participant, rt)
arrange(blp_df, spell)


# pipelines with %>% ------------------------------------------------------

x <- c(1, 2, 3, 5, 11, 17)
log(x) # log to base e of x
sqrt(log(x)) # sqrt of the log of x 
sum(sqrt(log(x))) # sum of sqrt of log of x
log(sum(sqrt(log(x))))

# using intermediate data structures
log_x <- log(x)
sqrt_log_x <- sqrt(log_x)

# the nested functions in a pipeline
x %>% log() # same as log(x)
x %>% log() %>% sqrt() # same as sqrt(log(x))
x %>% log() %>% sqrt() %>% sum() %>% log() # same as log(sum(sqrt(log(x))))

# with intermediate data frames
blp_df_tmp <- mutate(blp_df, accuracy = lex == resp)
blp_df_tmp_2 <- filter(blp_df_tmp, accuracy == TRUE)
select(blp_df_tmp_2, participant, spell, rt)

blp_df_2 <- mutate(blp_df, accuracy = lex == resp) %>% 
  filter(accuracy == TRUE) %>% 
  select(participant, spell, rt)

mutate(blp_df, accuracy = lex == resp) %>% 
  filter(accuracy == TRUE) %>% 
  select(participant, spell, rt) -> blp_df_2

read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/blp-trials-short.txt") %>% 
  mutate(accuracy = lex == resp) %>% 
  filter(accuracy == TRUE) %>% 
  select(participant, spell, rt)
