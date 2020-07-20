#' Query for source definition
#' @export

query_cui_attributes <-
        function(cui) {
                base <- system.file(package = "metaorite")
                path <- paste0(base, "/sql/mrsatAttributes.sql")
                sql_statement <- 
                    SqlRender::render(SqlRender::readSql(path),
                                      cui = cui)
                
                output <- submitQuery(sql_statement)
                return(output)
        }
