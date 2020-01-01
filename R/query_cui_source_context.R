#' Query for source definition
#' @import mySeagull
#' @export

query_cui_source_context <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRHIER WHERE CUI = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
