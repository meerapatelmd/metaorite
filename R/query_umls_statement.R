#' Query for source definition
#' @import mySeagull
#' @export

query_umls_statement <-
        function(sql_statement) {
                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }
