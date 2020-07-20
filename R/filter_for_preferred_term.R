#' Filter MRCONSO output for preferred_term
#' @importFrom dplyr filter
#' @export

filter_for_pt <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        dplyr::filter(TTY == "PT")
                return(x)
        }
