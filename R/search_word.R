#' @title
#' Search for a Word in the MRXW Table
#'
#' @description
#' Unlike the other Search functions that take a `concept` as an argument, this function looks up words and returns all possible matches by CUI and SUI from MRCONSO. More information is available at https://www.nlm.nih.gov/research/umls/implementation_resources/query_diagrams/er6.html.
#'
#' @param conn          Database connection
#' @param schema        Metathesaurus schema
#' @param word          Word to search
#'
#' @seealso
#'  \code{\link[pg13]{query}}
#'  \code{\link[SqlRender]{render}}
#' @rdname query_word
#' @export
#' @importFrom pg13 query
#' @importFrom SqlRender render


query_word <-
        function(conn,
                 schema,
                 word) {

                pg13::query(conn = conn,
                                SqlRender::render(
                                                "SELECT m.*,
                                                        mrxw.wd as mrxw_wd
                                                        mrxw.lui as mrxw_lui
                                                FROM @schema.MRCONSO m
                                                LEFT JOIN @schema.MRXW_ENG mrxw
                                                ON mrxw.CUI = m.CUI
                                                   AND mrxw.SUI = m.SUI
                                                WHERE mrxw.WD = '@word';",
                                                schema = schema,
                                                word = word)
                )

        }
