#' Filter MRCONSO output for preferred_term
#' @importFrom dplyr filter
#' @export

filter_for_nci <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        dplyr::filter(TTY == "PT")
                return(x)
        }
