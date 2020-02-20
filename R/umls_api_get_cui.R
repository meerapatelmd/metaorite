#' Gets the most current information about a CUI via API call
#' @param cui CUI to query
#' @return response object or an Error message in console
#' @importFrom httr GET
#' @importFrom mirCat typewrite
#' @export

umls_api_get_cui <-
        function(cui) {
                #baseURL <- "https://uts-ws.nlm.nih.gov/rest"
                SERVICE_TICKET <- umls_api_auth()

                if (is.null(SERVICE_TICKET)) {
                        file.remove("~/Lockbox/.umls_auth_tgt.txt")
                        SERVICE_TICKET <- umls_api_auth()
                }

                if (!(is.null(SERVICE_TICKET))) {
                        file.remove("~/Lockbox/.umls_auth_service_ticket.txt")
                        resp <- httr::GET(url = paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", cui, "?ticket=", SERVICE_TICKET))
                        return(resp)
                } else {
                        mirCat::typewrite("ERROR: SERVICE_TICKET is null even after reseting TGT.")

                }
        }
