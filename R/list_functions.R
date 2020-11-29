#' @title
#' List Database Elements
#'
#' @description
#' List details on the MTH database architecture
#'
#' @return
#' Vector of 1 or more values
#'
#' @param conn   Postgres Connection
#' @param schema Schema of MTH instance
#'
#' @name list_functions
#' @keywords internal
NULL


#' @title
#' List Fields
#'
#' @inherit return_valueset_functions description
#' @inheritParams return_valueset_functions
#' @param table MTH Table
#'
#' @details
#' List the fields in a MTH Table.
#'
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#'
#' @rdname list_fields
#'
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

list_fields <-
        function(conn,
                 schema = "mth",
                 table) {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '@schema' AND TABLE_NAME = '@table';",
                                                                                schema = schema,
                                                                                table = table)) %>%
                        unlist() %>%
                        unname()

        }
