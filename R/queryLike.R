#' Query based on search terms
#' @import SqlRender
#' @export

queryLike <-
        function(phrase, 
                 caseInsensitive = TRUE,
                 limit_n = NULL) {
            
                base <- system.file(package = "metaorite")
                path <- paste0(base, "/sql")
            
                if (caseInsensitive) {
                    
                        if (is.null(limit_n)) {
                            
                            
                            path <- paste0(path, "/queryLowerLike.sql")
                            sql_statement <- 
                                SqlRender::render(SqlRender::readSql(path),
                                                  phrase = tolower(phrase))
                            
                            
                            
                        } else {
                            
                            
                            path <- paste0(path, "/queryLowerLimitLike.sql")
                            sql_statement <- 
                                SqlRender::render(SqlRender::readSql(path),
                                                  phrase = tolower(phrase),
                                                  limit_n = limit_n)
                            
                            
                        }
                    
                    
                } else {
                    
                    
                        if (is.null(limit_n)) {
                            
                            
                            path <- paste0(path, "/queryLike.sql")
                            sql_statement <- 
                                SqlRender::render(SqlRender::readSql(path),
                                                  phrase = phrase)
                            
                            
                            
                        } else {
                            
                            
                            path <- paste0(path, "/queryLimitLike.sql")
                            sql_statement <- 
                                SqlRender::render(SqlRender::readSql(path),
                                                  phrase = phrase,
                                                  limit_n = limit_n)
                            
                            
                        }
                    
                }
                
                resultset <- loadCacheSQL(sql_statement = sql_statement)

                if (is.null(resultset)) {
                    
                        resultset <- submitQuery(sql_statement = sql_statement)
                        cacheSQL(object = resultset,
                                 sql_statement = sql_statement)
                    
                }

                return(resultset)
                
        }
