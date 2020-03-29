#' Filter MRCONSO output for LOINC
#' @importFrom dplyr filter
#' @export

filter_for_loinc <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        dplyr::filter(SAB == "LNC")
                return(x)
        }
