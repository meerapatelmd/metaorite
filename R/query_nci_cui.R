#' Query for source definition
#' @import mySeagull
#' @export

query_nci_cui <-
        function(nci_cui, nci_code_cui_map_table = "nci_code_cui_map_201808") {
                conn_to_nci_metathesaurus <- mySeagull::connect_to_local_postgres(dbname = "nci_metathesaurus")

                sql_statement <- paste0("SELECT * FROM ", nci_code_cui_map_table, " WHERE nci_cui1 = '", nci_cui, "' OR nci_cui2 = '", nci_cui, "';")

                print(sql_statement)

                resultset <- DBI::dbGetQuery(conn = conn_to_nci_metathesaurus, statement = sql_statement)
                DBI::dbDisconnect(conn_to_nci_metathesaurus)
                return(resultset)
        }
