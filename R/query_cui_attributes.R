#' Query for source definition
#' @export

query_cui_attributes <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRSAT WHERE STYPE = 'CUI' AND CUI = '", cui, "';")

                output <- submit_query(sql_statement)
                return(output)
        }
