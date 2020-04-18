#' Queries cui in UMLS in MRCONSO table of metathesaurus
#' @param cui C-prefixed CUI from metathesaurus
#' @param limit LIMIT in the sql statement. If NULL, all records will be returned.
#' @return resultset from SQL query
#' @importFrom DBI dbGetQuery
#' @export

query_cui <-
        function(cui, limit = NULL) {

                if (is.null(limit)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI = '", cui, "' AND
                                                                        LAT = 'ENG' AND ISPREF = 'Y';")
                } else {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI = '", cui, "' AND
                                                                        LAT = 'ENG' AND ISPREF = 'Y' LIMIT ", limit, ";")
                }

                resultset <- submit_query(sql_statement = sql_statement)

                return(resultset)
        }
