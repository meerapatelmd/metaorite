#' Query for source definition
#' @import mySeagull
#' @export

query_cui_attributes <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRSAT WHERE STYPE = 'CUI' AND CUI = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
