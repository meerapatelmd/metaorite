#' @title
#' Lookup a Code in MRCONSO Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_code
#' @family code lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render


lookup_code <-
        function(conn,
                 code,
                 sab,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
                            sql_statement =
                                    SqlRender::render(
                                            "
                                    SELECT *
                                    FROM @schema.MRCONSO
                                    WHERE
                                            code = '@code'
                                            AND sab = '@sab';",
                                            code = code,
                                            sab = sab,
                                            schema = schema)
                )
        }
