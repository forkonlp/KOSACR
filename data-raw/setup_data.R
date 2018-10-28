library(stringr)
library(dplyr)
library(readr)

tar <- "http://word.snu.ac.kr/kosac/data/lexicon.zip"
download.file(tar, "data-raw/lexicon.zip")
unzip(zipfile = "data-raw/lexicon.zip", exdir = "./data-raw")

# type <- read_csv("./data-raw/expressive-type.csv")
# no <- read_csv("./data-raw/nested-order.csv")

intensity <- read_csv("./data-raw/intensity.csv") %>%
  arrange(ngram) %>%
  mutate(token = ngram,
         ngram = str_count(token, ";") + 1) %>%
  select(token, ngram, max.value) %>%
  rename(value = max.value)

polarity <- read_csv("./data-raw/polarity.csv") %>%
  arrange(ngram) %>%
  mutate(token = ngram,
         ngram = str_count(token, ";") + 1) %>%
  select(token, ngram, max.value) %>%
  rename(value = max.value)

subj_polarity <- read_csv("./data-raw/subjectivity-polarity.csv") %>%
  arrange(ngram) %>%
  mutate(token = ngram,
         ngram = str_count(token, ";") + 1) %>%
  select(token, ngram, max.value) %>%
  rename(value = max.value)

subj_type <- read_csv("./data-raw/subjectivity-type.csv") %>%
  arrange(ngram) %>%
  mutate(token = ngram,
         ngram = str_count(token, ";") + 1) %>%
  select(token, ngram, max.value) %>%
  rename(value = max.value)

sentiments <- bind_rows(
  list(
    intensity = intensity,
    polarity = polarity ,
    subj_polarity = subj_polarity,
    subj_type = subj_type
  ),
  .id = "lex"
)

use_data(sentiments, overwrite = T)
