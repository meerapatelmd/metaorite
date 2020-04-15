#' Query based on search terms
#' @export

query_exact_phrase_match <-
        function(phrase, limit = NULL) {
                if (is.null(limit)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR ='", phrase, "';")
                } else {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR ='", phrase, "' LIMIT ", limit, ";")
                }

                resultset <- submit_query(sql_statement = sql_statement)
                return(resultset)
        }
