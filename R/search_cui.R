#' Gets the most current information about a CUI via API call
#' @param cui CUI to query
#' @return response object or an Error message in console
#' @importFrom httr GET
#' @import secretary
#' @export

search_cui <-
        function(cui) {

                output <- loadCacheCUIResponse(cui = cui)
                
                if (is.null(output)) {
                    
                    SERVICE_TICKET <- umls_api_auth()
                    
                    if (is.null(SERVICE_TICKET)) {
                        file.remove("~/.umls_auth_tgt.txt")
                        SERVICE_TICKET <- umls_api_auth()
                    }
                    
                    if (!(is.null(SERVICE_TICKET))) {
                        file.remove("~/.umls_auth_service_ticket.txt")
                        resp <- httr::GET(url = paste0("https://uts-ws.nlm.nih.gov/rest/content/current/CUI/", cui, "?ticket=", SERVICE_TICKET))
                        
                        output <- 
                            umls_api_parse_response(umls_api_response = resp,
                                                    search_type = "cui")
                        
                        cacheCUIResponse(object = output,
                                         cui = cui)
                    } else {
                        secretary::typewrite("ERROR: SERVICE_TICKET is null even after reseting TGT.")
                        
                    }
                    
                }
                
                return(output)
        
        }
