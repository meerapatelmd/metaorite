#' @title
#' Lookup CUI Functions
#'
#' @description
#' Lookup the elements of a CUI
#'
#' @return
#' Resultset of 1 or more rows
#'
#' @param conn Postgres Connection
#' @param cui CUI
#' @param schema Schema of MTH instance
#'
#' @name lookup_functions
#' @keywords internal
NULL


#' @title
#' Lookup a CUI in MRCONSO Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_cui
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render


lookup_cui <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
                            sql_statement =
                            SqlRender::render(
                                    "
                                    SELECT *
                                    FROM @schema.MRCONSO
                                    WHERE CUI = '@cui';",
                                    cui = cui,
                                    schema = schema)
                )
        }


#' @title
#' Lookup a CUI in MRREL Table
#'
#' @inherit lookup_functions description return
#' @details This function sets the `cui` argument to CUI1 in the MRREL Table. For the inverse relationship, see \code{\link{lookup_inverse_rel}}
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_relationships
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_relationships <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
                            sql_statement =
                                SqlRender::render(
                                        "SELECT *
                                        FROM @schema.MRREL r
                                        LEFT JOIN @schema.MRCONSO m
                                        ON r.CUI2 = m.CUI
                                        WHERE r.CUI1 = '@cui';",
                                        cui = cui,
                                        schema = schema)
                )
        }


#' @title
#' Lookup a CUI in MRREL Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @details This function sets the `cui` argument to CUI2in the MRREL Table. For the non-inverse relationship, see \code{\link{lookup_relationships}}
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_inverse_rel
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_inverse_rel <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
                            sql_statement =
                            SqlRender::render(
                                    "SELECT *
                                        FROM @schema.MRREL r
                                        LEFT JOIN @schema.MRCONSO m
                                        ON r.CUI1 = m.CUI
                                        WHERE r.CUI2 = '@cui';",
                                    cui = cui,
                                    schema = schema)
                )
        }

#' @title
#' Lookup a CUI in the MRSTY Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_semantic_types
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_semantic_types <-
        function(conn,
                 cui,
                 schema = "mth") {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT *
                                                                FROM @schema.MRSTY
                                                                WHERE CUI = '@cui';",
                                                                cui = cui,
                                                                schema = schema))
        }


#' @title
#' Lookup a CUI in the MRHIER Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_source_context
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_source_context <-
        function(conn,
                 cui,
                 schema = "mth") {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT *
                                                                FROM @schema.MRHIER
                                                                WHERE CUI = '@cui';",
                                                              cui = cui,
                                                              schema = schema))
        }


#' @title
#' Lookup a CUI in the MRSAT Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_attributes
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_attributes <-
        function(conn,
                 cui,
                 schema = "mth") {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT * FROM @schema.MRSAT WHERE STYPE = 'CUI' AND CUI = '@cui';",
                                                              cui = cui,
                                                              schema = schema))
        }


#' @title
#' Lookup a CUI in the MRDEF Table
#'
#' @inherit lookup_functions description return
#' @inheritParams lookup_functions
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname lookup_source_defs
#' @family cui lookup
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render

lookup_source_defs <-
        function(conn,
                 cui,
                 schema = "mth") {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT *
                                                                FROM @schema.MRDEF
                                                                WHERE CUI = '@cui';",
                                                              cui = cui,
                                                              schema = schema))
        }

