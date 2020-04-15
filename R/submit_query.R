#' Submit Query for data retrieval from local umls
#' @importFrom DBI dbGetQuery
#' @export

submit_query <-
        function(sql_statement) {
                conn <- connect_to_local_umls()
                resultset <- DBI::dbGetQuery(conn = conn, statement = sql_statement)
                dc_local_umls(conn)

                return(resultset)
        }
