#' Filters MRCONSO table for STR values that exactly match values in the argument vector
#' @param vector vector of strings for IN statement in SQL query
#' @return resultSet where STR IN vector argument
#' @importFrom mySeagull get_query
#' @export


query_phrase_vector <-
        function(vector) {
                sql_statement <- paste0("SELECT * FROM MRCONSO WHERE STR IN (",paste(paste0("'", vector, "'"), collapse =  ", "), ");")
                resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                return(resultset)
        }
