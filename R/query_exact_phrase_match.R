#' Query based on search terms
#' @importFrom mySeagull get_query
#' @export

query_exact_phrase_match <-
        function(phrase, limit = NULL) {
                if (is.null(limit)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR ='", phrase, "';")
                } else {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR ='", phrase, "' LIMIT ", limit, ";")
                }

                resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                return(resultset)
        }
