#' Query NCI for a phrase using a LIKE statement
#' @import mySeagull
#' @export

query_nci_like_phrase <-
        function(nci_phrase, nci_code_cui_map_table = "nci_code_cui_map_201808") {
                conn_to_nci_metathesaurus <- mySeagull::connect_to_local_postgres(dbname = "nci_metathesaurus")

                sql_statement <- paste0("SELECT * FROM ", nci_code_cui_map_table," WHERE nci_str1 LIKE '%", nci_phrase, "%' OR nci_str2 = '%", nci_phrase, "%';")

                print(sql_statement)

                resultset <- DBI::dbGetQuery(conn = conn_to_nci_metathesaurus, statement = sql_statement)
                DBI::dbDisconnect(conn_to_nci_metathesaurus)
                return(resultset)
        }
