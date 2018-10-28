#' get_kosac
#'
#' @param lexicon "polarity" is default.
#' @importFrom dplyr filter select
#' @export
get_kosac <- function(lexicon = c("polarity", "intensity", "subj_polarity", "subj_type")) {
  data(list = "sentiments", package = "KOSACR", envir = environment())

  res <- sentiments %>%
    dplyr::filter(lex == lexicon) %>%
    dplyr::select(-lex)

  return(res)
}

