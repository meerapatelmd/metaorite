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

#' Query for source definition
#' @import mySeagull
#' @export

query_cui_inverse_relationships <-
        function(cui) {
                sql_statement <-
                        paste0("SELECT * FROM MRREL WHERE STYPE2 = 'CUI' AND CUI2 = '", cui, "';")

                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
