#' Disconnect a Local Metathesaurus Instance
#' @import preQL
#' @export

dcLocalMT <- 
    function(conn,
             ...) {
        
        preQL::dcMySQL5.5(conn = conn,
                          ...)
        
    }