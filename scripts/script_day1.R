library(tidyverse)

# Get some data -----------------------------------------------------------

blp_df <- read_csv("https://raw.githubusercontent.com/mark-andrews/dwdv01/master/data/blp-trials-short.txt")


# Wrangling ---------------------------------------------------------------

# verbs

# select 
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
