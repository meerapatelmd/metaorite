#' Takes the response object from the UMLS API Call and parses it into a dataframe
#' @param umls_api_response response object from a call to the UMLS API
#' @importFrom jsonlite fromJSON
#' @importFrom httr content
#' @import purrr
#' @import dplyr
#' @export

umls_api_parse_response <-
        function(umls_api_response) {
                parsed <- jsonlite::fromJSON(httr::content(umls_api_response, "text"), simplifyVector = FALSE)

                transposed <- parsed$result$results %>% purrr::transpose()

                as_df <- transposed %>%
                        purrr::map(function(x) tibble(t(unname(as.data.frame(x))))) %>%
                        purrr::keep(function(x) nrow(x) > 0) %>%
                        purrr::reduce(cbind)

                colnames(as_df) <- names(transposed)

                return(as_df)
        }
