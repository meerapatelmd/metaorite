#' Query for source definition
#' @export

query_umls_statement <-
        function(sql_statement) {
                output <- submit_query(sql_statement = sql_statement)
                return(output)
        }
