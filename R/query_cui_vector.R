#' Filters MRCONSO table for CUI values that exactly match values in the argument vector
#' @param vector vector of CUIs for IN statement in SQL query
#' @return resultSet where CUI IN vector argument
#' @importFrom mySeagull get_query
#' @export


query_cui_vector <-
        function(vector) {
                sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI IN (",paste(paste0("'", vector, "'"), collapse =  ", "), ");")
                resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                return(resultset)
        }
