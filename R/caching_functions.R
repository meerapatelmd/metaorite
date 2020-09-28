#' Cache SQL Statement
#' @importFrom R.cache saveCache
#' @export

cache_sql <-
    function(object, sql_statement) {

        R.cache::saveCache(object = object,
                           key = list(sql_statement),
                           dirs = "metaorite")

    }


#' Load Cached SQL Statement
#' @importFrom R.cache loadCache
#' @export

load_cached_sql <-
    function(sql_statement) {

        R.cache::loadCache(key = list(sql_statement),
                           dirs = "metaorite")

    }
