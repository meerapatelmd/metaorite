#' Returns all possible atoms associated with a single phrase search, either like or exact
#' @param phrase phrase to be searched
#' @param search_type like for double-ended wildcards in the SQL statement; exact for an exact match
#' @importFrom secretary typewrite
#' @export


return_all_possible_cuis <-
        function(phrase,
                 search_type = c("like", "exact"),
                 limit = NULL) {

                if (!(search_type %in% c("like", "exact"))) {
                        secretary::typewrite("`", search_type, "` is not a valid argument. Please try again. ")
                } else {
                        if (search_type == "like") {
                                resultset_a <- query_phrase_combo(phrase = phrase, limit = limit)
                        } else if (search_type == "exact") {
                                resultset_a <- query_exact_phrase_match(phrase = phrase, limit = limit)
                        }
                }

                resultset_b <-
                        query_cui_vector(vector = resultset_a$CUI)

                return(resultset_b)

        }
