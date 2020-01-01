#' Query based on search terms
#' @importFrom mySeagull get_query
#' @import dplyr
#' @import rubix
#' @export

query_str_combo_in_mrconso <-
        function(...) {
                Args <- list(...)

                for (i in 1:length(Args)) {
                        if (i == 1) {
                                sql_statement <- paste0("SELECT CUI, STR FROM MRCONSO WHERE LAT = 'ENG' AND ISPREF = 'Y' AND STR LIKE '%", Args[[1]], "%'")
                        } else {
                                sql_statement <- paste0(sql_statement,
                                                   paste0(" AND STR LIKE '%", Args[[i]], "%'"))
                        }
                }
                sql_statement <- paste0(sql_statement, ";")
                resultset <- mySeagull::get_query("umls", sql_statement = sql_statement)
                return(resultset %>%
                               rubix::call_mr_clean())
        }
