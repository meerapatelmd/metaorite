#' @title
#' Arrange by Character Count
#'
#' @description
#' Important in Like and String style functions where the lowest character count will likely be the closest match.
#'
#' @importFrom dplyr enquo mutate arrange select
#' @noRd

arrange_nchar <-
        function(.data, col) {

                col <- dplyr::enquo(col)

                .data %>%
                        dplyr::mutate(nchar = nchar(as.character(!!col))) %>%
                        dplyr::arrange(nchar) %>%
                        dplyr::select(-nchar)
        }


#' @title
#' Write a Temp Table
#'
#' @importFrom pg13 writeTable
#'
#' @noRd

write_temp_table <-
        function(conn,
                 schema,
                 data) {

                tempTableName <- paste0("V", stringr::str_remove_all(as.character(Sys.time()), "[^0-9]"))

                pg13::writeTable(conn = conn,
                                 schema = schema,
                                 tableName = tempTableName,
                                 data)

                tempTableName

        }

#' @title
#' Makes the JOIN ON portion of SQL Statement
#'
#' @noRd

match_join_columns <-
        function(...) {

                Args <- unlist(...)

                columns_a <- paste0("a.", names(Args))
                columns_b <- paste0("b.", unname(Args))

                mapply(function(x,y) paste(x, "=", y),
                       columns_a,
                       columns_b,
                       USE.NAMES = FALSE) %>%
                        paste(collapse = " AND ")

        }


#' @title
#' Render the SQL to Left Join on a Temp Table
#' @importFrom SqlRender render
#' @noRd

render_left_join <-
        function(fields = "*",
                 schema,
                 tempTableName,
                 joinOnSchema,
                 joinOnTable,
                 ...) {


                fields <- paste(fields, collapse = ",")

                joinStatement <- match_join_columns(...)

                SqlRender::render(
                                "SELECT @fields
                                FROM @schema.@tempTableName a
                                LEFT JOIN @joinOnSchema.@joinOnTable b
                                ON @joinStatement",
                                fields = fields,
                                schema = schema,
                                tempTableName = tempTableName,
                                joinOnSchema = joinOnSchema,
                                joinOnTable = joinOnTable,
                                joinStatement = joinStatement)

        }




#' @title
#' Drops all Temp Tables
#' @importFrom pg13 lsTables dropTable
#' @noRd

drop_temp_table <-
        function(conn,
                 schema) {


                tempTables <- pg13::lsTables(conn = conn,
                                             schema = schema) %>%
                                grep(pattern = "^V[0-9]{12,}$",
                                     value = TRUE)

                sapply(tempTables, function(x) pg13::dropTable(conn = conn,
                                                               schema = schema,
                                                               tableName = x))

        }


#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @noRd
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

