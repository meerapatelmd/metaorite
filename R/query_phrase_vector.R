#' Filters MRCONSO table for STR values that exactly match values in the argument vector
#' @param vector vector of strings for IN statement in SQL query
#' @return resultSet where STR IN vector argument
#' @importFrom purrr map
#' @importFrom dplyr bind_rows
#' @export


query_phrase_vector <-
        function(vector, limit_per_phrase = NULL) {
                if (is.null(limit_per_phrase)) {
                        sql_statement <- paste0("SELECT * FROM MRCONSO WHERE STR IN (",paste(paste0("'", vector, "'"), collapse =  ", "), ");")
                        resultset <- submit_query(sql_statement = sql_statement)
                        return(resultset)
                } else {
                        sql_statements <-
                        vector %>%
                                purrr::map(function(x) paste0("SELECT * FROM MRCONSO WHERE STR = '", x, "' LIMIT ", limit_per_phrase, ";"))

                        resultset <-
                        sql_statements %>%
                                purrr::map(submit_query) %>%
                                dplyr::bind_rows()

                        return(resultset)
                }

        }
