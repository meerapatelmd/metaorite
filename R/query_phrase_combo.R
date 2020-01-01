#' Query based on search terms
#' @importFrom mySeagull get_query
#' @import dplyr
#' @import rubix
#' @export

query_phrase_combo <-
        function(..., limit = NULL) {
                Args <- list(...)

                for (i in 1:length(Args)) {
                        if (i == 1) {
                                sql_statement <- paste0("SELECT * FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR LIKE '%", Args[[1]], "%'")
                        } else {
                                sql_statement <- paste0(sql_statement,
                                                   paste0(" AND STR LIKE '%", Args[[i]], "%'"))
                        }
                }

                if (is.null(limit)) {
                        sql_statement <- paste0(sql_statement, ";")
                } else {
                        sql_statement <- paste0(sql_statement, " LIMIT ", limit, ";")
                }

                resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                return(resultset)
        }
