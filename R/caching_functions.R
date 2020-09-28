#' Cache SQL Statement
#' @import R.cache
#' @export

cacheSQL <-
    function(object, sql_statement) {

        R.cache::saveCache(object = object,
                           key = list(sql_statement),
                           dirs = "umls")

    }


#' Load Cached SQL Statement
#' @import R.cache
#' @export

loadCacheSQL <-
    function(sql_statement) {

        R.cache::loadCache(key = list(sql_statement),
                           dirs = "umls")

    }
