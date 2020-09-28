#' Filter MRCONSO output for SNOMED
#' @importFrom dplyr filter
#' @export

filter_for_snomed <-
        function(mrconso_df) {
                x <-
                        mrconso_df %>%
                        dplyr::filter(SAB == "SNOMEDCT_US")
                return(x)
        }



## Map Sab to Athena

broca::view_as_csv(setupMetathesaurus::sab_annotation())
