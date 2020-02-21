#' UMLS API Search of a String
#' @param string string to search of length 1
#' @return a list of dataframes from one of each of the following search types: "exact","words","leftTruncation", "rightTruncation", "approximate", "normalizedString", "normalizedWords"
#' @description ##searchType Parameter Behaviors
#' * words: breaks a search term into its component parts, or words, and retrieves all concepts containing any of those words. For example: If you enter “Heart Disease, Acute” a Word search will retrieve all concepts containing any of the three words (heart, or disease, or acute).
#' * approximate: applies lexical variant generation (LVG) rules to the search term and generally results in expanded retrieval of concepts. For example, a search for the term “cold” retrieves all concepts that contain any of the following words: COLDs, chronic obstructive lung disease, chronic obstructive lung diseases, cold, colder, coldest.
#' * exact: retrieves only concepts that include a synonym that exactly matches the search term.
#' * Normalized String: use with English language terms only. Removes lexical variations such as plural and upper case text and compares search terms to the Metathesaurus normalized string index to retrieve relevant concepts. normalizedWords: use with English language terms only. Removes lexical variations such as plural and upper case text, and compares search terms to the Metathesaurus normalized word index to retrieve relevant concepts.
#' * rightTruncation: retrieves concepts with synonyms that begin with the letters of the search term. For example, a right truncation search for “bronch” retrieves concepts that contain synonyms such as bronchitis, bronchiole, bronchial artery.
#' * leftTruncation: retrieves concepts with synonyms that end with the letters of the search term. For example, a left truncation search for “itis” retrieves concepts that contain synonyms such as colitis, bronchitis, pancreatitis.
#' @importFrom httr GET
#' @importFrom mirCat typewrite
#' @export

umls_api_search <-
        function(string) {
                baseURL <- "https://uts-ws.nlm.nih.gov/rest"
                string <- URLencode(string)


                search_type <- c("exact","words","leftTruncation", "rightTruncation", "approximate", "normalizedString", "normalizedWords")
                resp <- list()
                for (i in 1:length(search_type)) {
                        SERVICE_TICKET <- umls_api_auth()
                        if (is.null(SERVICE_TICKET)|length(SERVICE_TICKET)==0) {
                                file.remove("~/Lockbox/.umls_auth_tgt.txt")
                                file.remove("~/Lockbox/.umls_auth_service_ticket.txt")
                                SERVICE_TICKET <- umls_api_auth()
                        }

                        if (!(is.null(SERVICE_TICKET))) {
                                file.remove("~/Lockbox/.umls_auth_service_ticket.txt")
                                resp[[i]] <- httr::GET(url = paste0(baseURL, "/search/current?string=", string,
                                                                    "&searchType=", search_type[i],
                                                                    "&ticket=", SERVICE_TICKET))
                        } else {
                                mirCat::typewrite("ERROR: SERVICE_TICKET is null even after reseting TGT.")

                        }
                }
                #return(resp)
                names(resp) <- search_type

                output <-  list()
                for (i in 1:length(resp)) {
                        output[[i]] <- umls_api_parse_response(resp[[i]])
                }
                names(output) <- search_type
                return(output)
        }

