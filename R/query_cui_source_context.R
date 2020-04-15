#' Query for source definition
#' @export

query_cui_source_context <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRHIER WHERE CUI = '", cui, "';")

                output <- submit_query(sql_statement)
                return(output)
        }
