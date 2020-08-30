#' @title
#' Get Source Vocabulary Information
#' @description
#' This function returns basic information on all the source vocabularies found in the UMLS Metathesaurus from the NIH site for \href{https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html}{UMLS Metathesaurus Vocabulary Documentation}.
#' @return
#' A data frame of the table found at  \href{https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html}{UMLS Metathesaurus Vocabulary Documentation}.
#' @details
#' This function assumes that the table of interest is found at https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html. Future modifications may be needed to update the web address should it be changed.
#' @export
#' @importFrom xml2 read_html
#' @importFrom rvest html_node html_table
#' @importFrom magrittr %>%

getVocabularyInfo <-
        function() {
                url <- "https://www.nlm.nih.gov/research/umls/sourcereleasedocs/index.html"
                data <- xml2::read_html(url)
                data %>%
                        rvest::html_node("table") %>%
                        rvest::html_table()
        }
