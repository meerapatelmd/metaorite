#' Query for source definition
#' @import mySeagull
#' @export

query_nci_statement <-
        function(sql_statement) {
                conn_to_nci_metathesaurus <- mySeagull::connect_to_local_postgres(dbname = "nci_metathesaurus")
                resultset <- DBI::dbGetQuery(conn = conn_to_nci_metathesaurus, statement = sql_statement)
                DBI::dbDisconnect(conn_to_nci_metathesaurus)
                return(resultset)
        }
