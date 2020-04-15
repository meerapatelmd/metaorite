#' Connect to MySQL 5.5 UMLS Database
#' @importFrom DBI dbConnect
#' @importFrom RMySQL MySQL
#' @export

connect_to_local_umls <-
        function () {
                DBI::dbConnect(RMySQL::MySQL(), dbname = "umls", username = Sys.getenv("umls_username"),
                               password = Sys.getenv("umls_password"), unix.socket = "/opt/local/var/run/mysql55/mysqld.sock")
}
