#' Query for source definition
#' @import mySeagull
#' @export

query_cui_relationships <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRREL WHERE CUI1 = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
