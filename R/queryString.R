#' String Style Query
#' @import pg13
#' @import stringr
#' @export

queryString <- 
        function(string, 
                 split,
                 caseInsensitive = TRUE) {
            
            
            sql_statement <-
            pg13::buildQueryString(schema = "public",
                                   tableName = "MRCONSO",
                                   whereLikeField = "STR",
                                   string = string,
                                   split = split,
                                   caseInsensitive = caseInsensitive) %>%
                stringr::str_replace_all("public.MRCONSO", "MRCONSO")
            
            
            
            resultset <- loadCacheSQL(sql_statement = sql_statement)
            
            if (is.null(resultset)) {
                
                
                    resultset <- submitQuery(sql_statement = sql_statement)
                    cacheSQL(object = resultset,
                             sql_statement = sql_statement)
                
            }
            
            return(resultset)
            
        }