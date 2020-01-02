#'Get all unique semantic types in Metathesaurus
#'@importFrom mySeagull get_query
#'@export


return_all_semantic_types <-
        function() {
                sql_statement <- paste0("SELECT DISTINCT STY FROM MRSTY;")
                output <- mySeagull::get_query("umls", sql_statement)
                return(output)
        }


