#' Query for source definition
#' @export

query_cui_semantic_types <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRSTY WHERE CUI = '", cui, "';")

                output <- submit_query(sql_statement)
                return(output)
        }
