#' Filter MRCONSO output for RXNORM
#' @importFrom dplyr filter
#' @export

filter_for_rxnorm <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        dplyr::filter(SAB == "RXNORM")
                return(x)
        }
