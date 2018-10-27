library(dplyr)
library(tibble)
library(stringr)
library(tidyr)

knu_lexicon
jsonlite::fromJSON("https://raw.githubusercontent.com/park1200656/KnuSentiLex/master/KnuSentiLex/data/SentiWord_info.json") %>%
  as_tibble() %>%
  select(word, polarity) %>%
  mutate(ngram = str_count(word, " ") + 1) %>%
  filter(ngram == 2) %>%
  separate(word, into = c("w1","w2")) -> n2


jsonlite::fromJSON("https://raw.githubusercontent.com/park1200656/KnuSentiLex/master/KnuSentiLex/data/SentiWord_info.json") %>%
  as_tibble() %>%
  select(word, polarity) %>%
  mutate(ngram = str_count(word, " ") + 1) %>%
  filter(ngram == 1) -> n1

bind_rows(list(word = n2$w1, word = n2$w2)) %>%
  unique() -> n2

n1 %>% select(word) %>% unique %>% bind_rows(n2) %>% unique() %>% tail

