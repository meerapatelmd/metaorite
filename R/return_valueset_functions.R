#' @title
#' Return the Valueset for a Field
#'
#' @description
#' Return a valueset to see what the possible values are in a given Field
#'
#' @return
#' Vector of 1 or more values
#'
#' @param conn   Postgres Connection
#' @param schema Schema of MTH instance
#' @param table  MTH Table
#' @param field  Field
#'
#' @name return_valueset_functions
#' @keywords internal
NULL


#' @title
#' Return Valueset
#'
#' @inherit return_valueset_functions description
#' @inheritParams return_valueset_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#'
#' @rdname return_valueset
#'
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

return_valueset <-
        function(conn,
                 schema = "mth",
                 table,
                 field) {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT DISTINCT @field FROM @schema.@table;",
                                                                                schema = schema,
                                                                                table = table,
                                                                                field = field)) %>%
                        unlist() %>%
                        unname()

        }
