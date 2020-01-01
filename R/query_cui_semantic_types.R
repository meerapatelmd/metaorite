#' Query for source definition
#' @import mySeagull
#' @export

query_cui_semantic_types <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRSTY WHERE CUI = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
