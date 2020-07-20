#' Connect to a local Metathesaurus Instance
#' @description MySQL 5.5 UMLS Database
#' @import preQL
#' @export

connectLocalMT <-
        function () {
            
            preQL::connectMySQL5.5(dbname = "umls",
                                   username = Sys.getenv("umls_username"),
                                   password = Sys.getenv("umls_password"))
}
