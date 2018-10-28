#' Bind the term frequency and inverse document frequency of a tidy text
#' dataset to the dataset
#'
#' Calculate and bind the term frequency and inverse document frequency of a
#' tidy text dataset, along with the product, tf-idf, to the dataset. Each of
#' these values are added as columns. This function supports non-standard
#' evaluation through the tidyeval framework.
#'
#' @param tbl A tidy text dataset with one-row-per-sentence-per-document
#' @param sentence Column containing sentence as string
#' @param simple TRUE/FALSE. TRUE means score's only 0 or 1. FALSE maens score's 0 to 3.
#' @param subjectivity TRUE/FALSE. Default is FALSE.
#'
#' @export

bind_stm_score <- function(tbl, sentence, simple, subjectivity = F) {
  UseMethod("bind_stm_score")
}

#' @export
bind_stm_score.default <- function(tbl, sentence, simple, subjectivity = F) {
  sentence <- compat_as_lazy(enquo(sentence))
  simple <- compat_as_lazy(enquo(simple))
  subjectivity <- compat_as_lazy(enquo(subjectivity))

  bind_stm_score_(tbl, sentence, simple, subjectivity)
}

#' @export
bind_stm_score.data.frame <- function(tbl, sentence, simple, subjectivity = F) {
  sentence <- quo_name(enquo(sentence))
  simple <- quo_name(enquo(simple))
  subjectivity <- quo_name(enquo(subjectivity))

  sentences <- as.character(tbl[[sentence]])
  if(subjectivity) {

  }


  tbl
}

#' @rdname deprecated-se
#' @inheritParams bind_stm_score
#' @param sentence,ngram,subjectivity target sentences, scoring ngram 1 to 3, subjectivity score or not
#' @export
bind_stm_score_ <- function(tbl, sentence, ngram, subjectivity = F) {
  UseMethod("bind_stm_score_")
}

#' @export
bind_stm_score_.data.frame <- function(tbl, sentence, ngram, subjectivity = F) {
  sentence <- compat_lazy(sentence, caller_env())
  ngram <- compat_lazy(ngram, caller_env())
  subjectivity <- compat_lazy(subjectivity, caller_env())
  bind_stm_score(tbl, !!sentence, !!ngram, !!subjectivity)
}
