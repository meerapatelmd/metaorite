
#' @param skip_cache If TRUE, the cache is skipped altogether. The database is directly queried and the resultset is not cached.
#' @param override_cache If TRUE, the cache is not loaded, the database is directly queried and the resultset is cached, overwriting any existing cache that may have been present.




search_exact <-
        function(conn,
                 concept,
                 schema = "mth",
                 match_case = TRUE,
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

                                if (is.null(resultset)) {

                                        resultset <-
                                        pg13::query(conn = conn,
                                                    sql_statement = sql_statement)

                                        cache_sql(object = resultset,
                                                  sql_statement = sql_statement)

                                }
                        }
                }


                resultset


        }
