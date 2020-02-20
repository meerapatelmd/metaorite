#'Integrate personal and internal boards in Teamwork
#'@param projectid "487470" for Meeracle Worker, "487152" for Internal Board
#'@import httr
#'@importFrom jsonlite fromJSON
#'@export

tw_get_tasks <- function(projectid) {

        url <- paste0("https://mskcc.teamwork.com/projects/", projectid, "/tasks.json")

        resp <- httr::GET(url,
             config = authenticate(user = Sys.getenv("TEAMWORK_API_TOKEN"),
                          password = "X",
                          type = "basic"))

        if (http_type(resp) != "application/json") {
                stop("API did not return json", call. = FALSE)
        }

        parsed <- jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)


        transposed <- parsed$`todo-items` %>% purrr::transpose()

        as_df <- transposed %>%
                        purrr::map(function(x) tibble(t(unname(as.data.frame(x))))) %>%
                        purrr::keep(function(x) nrow(x) > 0) %>%
                        purrr::reduce(cbind)


        colnames(as_df) <- names(transposed %>%
                                purrr::map(function(x) tibble(t(unname(as.data.frame(x))))) %>%
                                purrr::keep(function(x) nrow(x) > 0))
       return(as_df)
}
