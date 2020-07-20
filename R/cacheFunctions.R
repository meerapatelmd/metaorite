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




#' Cache API Search Response
#' @import R.cache
#' @export

cacheSearchResponse <-
    function(object, string) {
        
        R.cache::saveCache(object = object,
                           key = list(string),
                           dirs = "umls")
    }

#' Cache API CUI Response
#' @import R.cache
#' @export

cacheCUIResponse <-
    function(object, cui) {
        
        R.cache::saveCache(object = object,
                           key = list(cui),
                           dirs = "umls")
    }

#' Load API CUI Response
#' @import R.cache
#' @export

loadCacheCUIResponse <-
    function(cui) {
        
        R.cache::loadCache(key = list(cui),
                           dirs = "umls")
    }


#' Load Cache API Search Response
#' @import R.cache
#' @export

loadCacheSearchResponse <-
    function(string) {
        
        R.cache::loadCache(key = list(string),
                           dirs = "umls")
    }