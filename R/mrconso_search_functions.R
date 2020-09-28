#' @title
#' Search MRCONSO Functions
#'
#' @description
#' These functions help search for mappings between an a concept and a Metathesaurus identifier in the MRCONSO Table. All queries are cached using the R.cache package for quicker retrieval of the more computationally expensive searches.
#'
#' @param conn           Postgres connection
#' @param schema         Metathesaurus schema
#' @param concept        Concept to be searched
#' @param match_case     If TRUE, both the MRCONSO STR column and the `concept` argument are converted to lowercase.
#' @param cache_only     If TRUE, only the cache is loaded and database querying is skipped. If a cache did not exist for the query, a NULL will be returned.
#' @param skip_cache     If TRUE, the cache is skipped altogether. The database is directly queried and the resultset is not cached.
#' @param override_cache If TRUE, the cache is not loaded, the database is directly queried and the resultset is cached, overwriting any existing cache that may have been present.
#'
#' @return
#' Dataframe of 0 or more rows
#'
#' @name mrconso_search_functions
NULL


#' @title
#' Search for an Exact Match
#'
#' @inherit mrconso_search_functions description return
#' @inheritParams mrconso_search_functions
#'
#' @seealso
#'  \code{\link[SqlRender]{render}}
#'  \code{\link[pg13]{query}}
#' @rdname search_exact
#' @export
#' @importFrom SqlRender render
#' @importFrom pg13 query

search_exact <-
        function(conn,
                 concept,
                 schema = "mth",
                 match_case = TRUE,
                 cache_only = FALSE,
                 skip_cache = FALSE,
                 override_cache = FALSE) {

                if (match_case) {

                        sql_statement <-
                        SqlRender::render("SELECT * FROM @schema.mrconso WHERE LOWER(str) = LOWER('@concept');",
                                          schema = schema,
                                          concept = concept)

                } else {

                        sql_statement <-
                        SqlRender::render("SELECT * FROM @schema.mrconso WHERE str = '@concept';",
                                          schema = schema,
                                          concept = concept)

                }

                if (skip_cache) {

                        resultset <-
                                pg13::query(conn = conn,
                                            sql_statement = sql_statement)


                } else {

                        if (override_cache) {

                                resultset <-
                                        pg13::query(conn = conn,
                                                    sql_statement = sql_statement)

                                cache_sql(object = resultset,
                                          sql_statement = sql_statement)


                        } else {

                                resultset <- load_cached_sql(sql_statement = sql_statement)

                                if (!cache_only) {

                                        if (is.null(resultset)) {

                                                resultset <-
                                                pg13::query(conn = conn,
                                                            sql_statement = sql_statement)

                                                cache_sql(object = resultset,
                                                          sql_statement = sql_statement)

                                        }
                                }
                        }
                }


                resultset

        }


#' @title
#' Search for a Like Match
#'
#' @inherit mrconso_search_functions description return
#' @inheritParams mrconso_search_functions
#'
#' @details
#' A 'Like' match is one where there is match for a search where there is a wildcard added on both ends of the `concept`
#'
#' @seealso
#'  \code{\link[SqlRender]{render}}
#'  \code{\link[pg13]{query}}
#' @rdname search_exact
#' @export
#' @importFrom SqlRender render
#' @importFrom pg13 query


search_like <-
        function(conn,
                 concept,
                 schema = "mth",
                 match_case = TRUE,
                 cache_only = FALSE,
                 skip_cache = FALSE,
                 override_cache = FALSE) {

                if (match_case) {

                        sql_statement <-
                                SqlRender::render("SELECT * FROM @schema.mrconso WHERE LOWER(str) LIKE LOWER('%@concept%');",
                                                  schema = schema,
                                                  concept = concept)

                } else {

                        sql_statement <-
                                SqlRender::render("SELECT * FROM @schema.mrconso WHERE str LIKE '%@concept%';",
                                                  schema = schema,
                                                  concept = concept)

                }

                if (skip_cache) {

                        resultset <-
                                pg13::query(conn = conn,
                                            sql_statement = sql_statement)


                } else {

                        if (override_cache) {

                                resultset <-
                                        pg13::query(conn = conn,
                                                    sql_statement = sql_statement)

                                cache_sql(object = resultset,
                                          sql_statement = sql_statement)


                        } else {

                                resultset <- load_cached_sql(sql_statement = sql_statement)

                                if (!cache_only) {

                                        if (is.null(resultset)) {

                                                resultset <-
                                                        pg13::query(conn = conn,
                                                                    sql_statement = sql_statement)

                                                cache_sql(object = resultset,
                                                          sql_statement = sql_statement)

                                        }
                                }
                        }
                }


                resultset

        }


#' @title
#' Search for a Like Match
#'
#' @inherit mrconso_search_functions description return
#' @inheritParams mrconso_search_functions
#' @param split  Regular expression to split the concept on to generate words for this style of search. Defaults to a space.
#' @details
#' A 'String' style of search splits the concept into a vector of length 1 or greater based on the `split` argument. Seaches of this style will return all matches where all the results of the split were present.
#'
#' @seealso
#'  \code{\link[pg13]{buildQueryString}},\code{\link[pg13]{query}}
#' @rdname search_string
#' @export
#' @importFrom pg13 buildQueryString query

search_string <-
        function(conn,
                 concept,
                 split = " ",
                 schema = "mth",
                 match_case = TRUE,
                 skip_cache = FALSE,
                 override_cache = FALSE) {

                if (match_case) {

                        sql_statement <-
                                pg13::buildQueryString(schema = schema,
                                                     tableName = "mrconso",
                                                     whereLikeField = "str",
                                                     string = concept,
                                                     split = split)

                } else {

                        sql_statement <-
                                pg13::buildQueryString(schema = schema,
                                                     tableName = "mrconso",
                                                     whereLikeField = "str",
                                                     string = concept,
                                                     caseInsensitive = FALSE,
                                                     split = split)

                }

                if (skip_cache) {

                        resultset <-
                                pg13::query(conn = conn,
                                            sql_statement = sql_statement)


                } else {

                        if (override_cache) {

                                resultset <-
                                        pg13::query(conn = conn,
                                                    sql_statement = sql_statement)

                                cache_sql(object = resultset,
                                          sql_statement = sql_statement)


                        } else {

                                resultset <- load_cached_sql(sql_statement = sql_statement)

                                if (!cache_only) {

                                        if (is.null(resultset)) {

                                                resultset <-
                                                        pg13::query(conn = conn,
                                                                    sql_statement = sql_statement)

                                                cache_sql(object = resultset,
                                                          sql_statement = sql_statement)

                                        }
                                }
                        }
                }


                resultset

        }
