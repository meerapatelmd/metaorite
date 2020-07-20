#' Submit Query for data retrieval from local umls
#' @importFrom DBI dbGetQuery
#' @param ... Additional arguments passed to DBI's dbGetQuery function
#' @export

submitQuery <-
        function(sql_statement, ...) {
                conn <- connectLocalMT()
                resultset <- DBI::dbGetQuery(conn = conn,
                                             statement = sql_statement,
                                             ...)
                dcLocalMT(conn = conn)

                return(resultset)
        }
