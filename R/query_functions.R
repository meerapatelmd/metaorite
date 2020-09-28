


#' Query CUI
#' @export

query_cui <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
                            SqlRender::render(
                                    "SELECT *
                                        FROM @schema.MRCONSO
                                        WHERE CUI = '@cui';",
                                    cui = cui,
                                    schema = schema)
                )
        }


#' Query for relationships
#' @importFrom dplyr rename_all
#' @importFrom dplyr left_join
#' @importFrom dplyr rename_all
#' @export

query_cui_relationships <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
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


#' @export

query_cui_inverse_rel <-
        function(conn,
                 cui,
                 schema = "mth") {

                # cui <- "C0009443"
                # schema = "mth"

                pg13::query(conn = conn,
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

#' Query for sermantic type
#' @family query
#' @export

query_cui_semantic_types <-
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


#' Query for source context
#' @family query
#' @export

query_cui_source_context <-
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


#' Query for Attributes
#' @family query
#' @export

query_cui_attributes <-
        function(conn,
                 cui,
                 schema = "mth") {

                pg13::query(conn = conn,
                            sql_statement = SqlRender::render("SELECT * FROM @schema.MRSAT WHERE STYPE = 'CUI' AND CUI = '@cui';",
                                                              cui = cui,
                                                              schema = schema))
        }


#' Query for source definitions
#' @family query
#' @export

query_cui_source_definitions <-
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

