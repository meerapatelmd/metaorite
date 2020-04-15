#' Disconnect MySQL 5.5 UMLS Database
#' @importFrom DBI dbDisconnect
#' @export

dc_local_umls <-
        function (conn) {
                DBI::dbDisconnect(conn = conn)
}
