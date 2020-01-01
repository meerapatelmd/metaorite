#' Query for source definition
#' @import mySeagull
#' @export

query_cui_source_definition <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRDEF WHERE CUI = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
