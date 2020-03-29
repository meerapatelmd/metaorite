#' Filter MRCONSO output for NCI
#' @importFrom rubix filter_at_grepl
#' @export

filter_for_nci <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        rubix::filter_at_grepl(col = SAB,
                                               grepl_phrase = "NCI")
                return(x)
        }
