#' Query for source definition
#' @export

query_cui_relationships <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRREL WHERE CUI1 = '", cui, "';")

                output <- submit_query(sql_statement)
                return(output)
        }
