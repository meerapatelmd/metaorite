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


#' @title
#' Get Abbreviation Information
#' @description
#' Get all the tables that provide abbreviation information at the NIH site \href{https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/release/abbreviations.html}{Abbreviations}
#' @return
#' A list of data frames scraped from \href{https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/release/abbreviations.html}{Abbreviations}
#' @seealso
#'  \code{\link[xml2]{read_xml}}
#'  \code{\link[rvest]{html_nodes}},\code{\link[rvest]{html_table}}
#'  \code{\link[purrr]{set_names}}
#' @rdname getAbbreviationInfo
#' @export
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_table
#' @importFrom purrr set_names
#' @importFrom magrittr %>%

getAbbreviationInfo <-
        function() {
                url <- "https://www.nlm.nih.gov/research/umls/knowledge_sources/metathesaurus/release/abbreviations.html"
                data <- xml2::read_html(url)

                tableNames <-

                        tryCatch(
                                data %>%
                                        rvest::html_nodes("div p") %>%
                                        .[1] %>%
                                        html_text() %>%
                                        strsplit(split = "[|]{1}") %>%
                                        unlist() %>%
                                        trimws(),
                                error = function(e) NULL)



                payLoad <-
                        data %>%
                                rvest::html_nodes("table") %>%
                                rvest::html_table(fill = TRUE)

                if (length(payLoad) == length(tableNames)) {
                        payLoad %>%
                                purrr::set_names(tableNames)
                } else {
                        payLoad
                }
        }

