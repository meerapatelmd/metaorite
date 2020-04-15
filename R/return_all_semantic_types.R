#'Get all unique semantic types in Metathesaurus
#'@export


return_all_semantic_types <-
        function() {
                sql_statement <- paste0("SELECT DISTINCT STY FROM MRSTY;")
                output <- submit_query(sql_statement)
                return(output)
        }


