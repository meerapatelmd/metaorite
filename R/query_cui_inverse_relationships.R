#' Query for source definition
#' @export

query_cui_inverse_relationships <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRREL WHERE STYPE2 = 'CUI' AND CUI2 = '", cui, "';")

                output <- submit_query(sql_statement)
                return(output)
        }
