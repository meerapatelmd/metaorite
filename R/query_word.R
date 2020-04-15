#' Query MRXW_ENG table for word and return matching CUI and SUI values in MRCONSO
#' @param word phrases will return 0.
#' @export


query_word <-
        function(word) {
                sql_statement <- paste0("SELECT * FROM MRXW_ENG WHERE WD = '", word, "';")
                resultset <- submit_query(sql_statement)

                output <-
                        submit_query(paste0("SELECT * FROM MRCONSO WHERE CUI IN (", paste(paste0("'", unique(resultset$CUI), "'"), collapse = ", "), ") AND SUI IN (",  paste(paste0("'", unique(resultset$SUI), "'"), collapse = ", "), ");"))
                return(output)
        }
