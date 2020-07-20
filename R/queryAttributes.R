#' Query for source definition
#' @export

queryAttributes <-
        function(cui) {
                base <- system.file(package = "metaorite")
                path <- paste0(base, "/sql/mrsatAttributes.sql")
                sql_statement <- 
                    SqlRender::render(SqlRender::readSql(path),
                                      cui = cui)
                
                resultset <- loadCacheSQL(sql_statement = sql_statement)
                
                if (is.null(resultset)) {
                    
                        resultset <- submitQuery(sql_statement)
                        cacheSQL(object = resultset,
                                 sql_statement = sql_statement)
                        
                }
                return(output)
        }
