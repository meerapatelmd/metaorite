#' Filters MRCONSO table for CUI values that exactly match values in the argument vector
#' @param vector vector of CUIs for IN statement in SQL query
#' @return resultSet where CUI IN vector argument
#' @importFrom mySeagull get_query
#' @export


query_cui_vector <-
        function(vector, limit_per_cui = NULL) {
                if (is.null(limit_per_cui)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE CUI IN (",paste(paste0("'", vector, "'"), collapse =  ", "), ");")
                        resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                        return(resultset)
                } else {
                        sql_statements <-
                                vector %>%
                                purrr::map(function(x) paste0("SELECT * FROM MRCONSO WHERE CUI = '", x, "' LIMIT ", limit_per_cuif, ";"))

                        resultset <-
                                sql_statements %>%
                                purrr::map(mySeagull::get_query, dbname = "umls") %>%
                                dplyr::bind_rows()

                        return(resultset)
                }

        }
