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
#' Dataframe of 0 or more rows of all the fields in the MRCONSO Table.
#'
#' @name mrconso_search_functions
#' @family search mrconso
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
#' @family search mrconso
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


                resultset %>%
                        arrange_nchar()

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
#' @rdname search_like
#' @family search mrconso
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


                resultset %>%
                        arrange_nchar()

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
#' @family search mrconso
#' @export
#' @importFrom pg13 buildQueryString query

search_string <-
        function(conn,
                 concept,
                 split = " ",
                 schema = "mth",
                 match_case = TRUE,
                 cache_only = FALSE,
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


                resultset %>%
                        arrange_nchar()

        }


#' @title
#' Search for Synonyms
#'
#' @description
#' This function performs a combination of searches using the \code{\link{search_mrconso_functions}} on a `concept`. The resultsets are then rejoined back onto the MRCONSO to get all possible strings. The direction is therefore from the `concept` to the CUI it matches and then from the CUI back to all the STR values that belong to the CUI. The types of search to use depends on the `concept`. For example, a very long gene name may not have an exact match, but may have very high yield 'string' matches because of the number of unique words. A 'like' match may be the least ideal since it casts a wide net in the search and the return may be to wide in breadth to search the use case.
#'
#' @return
#' The results of the search will have all the fields from the MRCONSO Table with an additional Search Type column indicating what search type the CUI was the result of.
#'
#' @inheritParams mrconso_search_functions
#' @inheritParams search_string
#' @param search_styles One or more of "exact", "string", and/or "like" search styles that correspond with the \code{\link{search_exact}}, \code{\link{search_string}}, and \code{\link{search_like}} functions respectively.
#'
#' @seealso
#'  \code{\link[tibble]{tibble}}
#'  \code{\link[dplyr]{bind}},\code{\link[dplyr]{mutate}},\code{\link[dplyr]{select}},\code{\link[dplyr]{distinct}}
#'  \code{\link[SqlRender]{render}}
#'  \code{\link[pg13]{query}}
#' @rdname search_synonym
#' @export
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows mutate select distinct
#' @importFrom SqlRender render
#' @importFrom pg13 query


search_synonym <-
        function(conn,
                 concept,
                 schema = "mth",
                 search_styles = c("exact", "string", "like"),
                 split = " ",
                 match_case = TRUE,
                 cache_only = FALSE,
                 skip_cache = FALSE,
                 override_cache = FALSE) {


                resultset <- tibble::tibble()

                if ("exact" %in% search_styles) {

                         resultset <-
                                 dplyr::bind_rows(resultset,
                                                        search_exact(conn = conn,
                                                                     concept = concept,
                                                                     schema = schema,
                                                                     match_case = match_case,
                                                                     cache_only = cache_only,
                                                                     skip_cache = skip_cache,
                                                                     override_cache = override_cache) %>%
                                                        dplyr::mutate(search_style = "exact")
                                 )

                }

                if ("like" %in% search_styles) {

                        resultset <-
                                dplyr::bind_rows(resultset,
                                                 search_like(conn = conn,
                                                              concept = concept,
                                                              schema = schema,
                                                              match_case = match_case,
                                                              cache_only = cache_only,
                                                              skip_cache = skip_cache,
                                                              override_cache = override_cache) %>%
                                                         dplyr::mutate(search_style = "like")
                                )

                }


                if ("string" %in% search_styles) {

                        resultset <-
                                dplyr::bind_rows(resultset,
                                                 search_string(conn = conn,
                                                             concept = concept,
                                                             split = split,
                                                             schema = schema,
                                                             match_case = match_case,
                                                             cache_only = cache_only,
                                                             skip_cache = skip_cache,
                                                             override_cache = override_cache) %>%
                                                         dplyr::mutate(search_style = "string")
                                )

                }


                tempTableName <-
                        write_temp_table(conn = conn,
                                         schema = schema,
                                         data = resultset %>%
                                                 dplyr::select(resultset_cui = cui, search_style) %>%
                                                 dplyr::distinct())

                sql_statement <-
                        SqlRender::render(
                                "SELECT a.search_style, b.*
                                FROM @schema.@tempTableName a
                                LEFT JOIN mth.mrconso b
                                ON a.resultset_cui = b.cui;",
                                schema = schema,
                                tempTableName = tempTableName)

                resultset <- pg13::query(conn = conn,
                                                sql_statement = sql_statement)

                drop_temp_table(conn = conn,
                                schema = schema)

                resultset

        }






