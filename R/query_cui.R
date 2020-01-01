#' Queries cui in UMLS in MRCONSO table of metathesaurus
#' @param umls_cui C-prefixed CUI from metathesaurus
#' @param limit LIMIT in the sql statement. If NULL, all records will be returned.
#' @return resultset from SQL query
#' @importFrom mySeagull get_query
#' @importFrom rubix call_mr_clean
#' @export

query_cui <-
        function(cui, limit = NULL) {

                if (is.null(limit)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI = '", umls_cui, "' AND
                                                                        LAT = 'ENG' AND ISPREF = 'Y';")
                } else {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI = '", umls_cui, "' AND
                                                                        LAT = 'ENG' AND ISPREF = 'Y' LIMIT ", limit, ";")
                }

                cohort <- mySeagull::get_query("umls", sql_statement)

                return(cohort %>% rubix::call_mr_clean())
        }
