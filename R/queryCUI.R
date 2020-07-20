#' Queries cui in UMLS in MRCONSO table of metathesaurus
#' @param cui C-prefixed CUI from metathesaurus
#' @param limit LIMIT in the sql statement. If NULL, all records will be returned.
#' @return resultset from SQL query
#' @importFrom DBI dbGetQuery
#' @import pg13
#' @export

queryCUI <-
        function(cui, limit_n = NULL) {
            
                    base <- system.file(package = "metaorite")
                    path <- paste0(base, "/sql")
                    path <- paste0(path, "/queryCUI.sql")

                if (is.null(limit_n)) {
                        path <- paste0(path, "/queryCUI.sql")
                        sql_statement <- 
                            SqlRender::render(SqlRender::readSql(path),
                                              cui = cui)
                } else {
                    
                        path <- paste0(path, "/queryLimitCUI.sql")
                        sql_statement <- 
                            SqlRender::render(SqlRender::readSql(path),
                                              cui = cui,
                                              n = limit_n)
                }

                resultset <- submitQuery(sql_statement = sql_statement)

                return(resultset)
        }
