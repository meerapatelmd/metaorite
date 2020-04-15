#' Query based on search terms
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

                resultset <- submit_query(sql_statement = sql_statement)
                return(resultset)
        }
