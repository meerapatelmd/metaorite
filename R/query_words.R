#' Query MRXW_ENG table for words and return matching CUI and SUI values in MRCONSO
#' @param ... words of length 1 each
#' @param type "or" if words are to be considered separate queries (as in the case of synonyms); "and" if words are to be combined into a phrase
#' @import purrr
#' @import dplyr
#' @importFrom mySeagull get_query
#' @importFrom typewriteR tell_me
#' @export


query_words <-
        function(..., type = c("or", "and")) {
                Args <- list(...)

                if (type == "or") {
                        output <-
                                Args %>%
                                purrr::map(query_word) %>%
                                purrr::set_names(Args) %>%
                                dplyr::bind_rows(.id = "WORD")
                        return(output)
                } else if (type == "and") {
                        for (i in 1:length(Args)) {
                                if (i == 1) {
                                        output <-
                                                query_word(Args[[1]])
                                } else {
                                        output <-
                                                output %>%
                                                dplyr::inner_join(query_word(Args[[i]]) %>%
                                                                          dplyr::select(CUI, SUI),
                                                                  by = c("CUI", "SUI"))
                                }
                        }
                        return(output)
                } else {
                        typewriteR::tell_me(type, "is not a valid answer. Please try again.")
                }
        }
