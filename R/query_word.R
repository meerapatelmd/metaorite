#' Query MRXW_ENG table for word and return matching CUI and SUI values in MRCONSO
#' @param word phrases will return 0.
#' @importFrom mySeagull get_query
#' @export


query_word <-
        function(word) {
                sql_statement <- paste0("SELECT * FROM MRXW_ENG WHERE WD = '", word, "';")
                resultset <- mySeagull::get_query("umls", sql_statement)

                output <-
                        mySeagull::get_query("umls",
                                             paste0("SELECT * FROM MRCONSO WHERE CUI IN (", paste(paste0("'", unique(resultset$CUI), "'"), collapse = ", "), ") AND SUI IN (",  paste(paste0("'", unique(resultset$SUI), "'"), collapse = ", "), ");")
                        )
                return(output)
        }
