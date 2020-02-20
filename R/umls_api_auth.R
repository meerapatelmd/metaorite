#'Authenticate UMLS REST API by 1) Generate TGT that is valid for 8 hours, 2) Generate a Service Ticket using TGT that is valid for 5 minutes. Use Service Ticket to make API calls.
#'@import httr
#'@importFrom stringr str_replace_all
#'@importFrom mirCat stamp_this
#'@return service ticket valid for up to 5 minutes or when a single API call is made
#'@importFrom jsonlite fromJSON
#'@export

umls_api_auth <- function() {

        ##Getting TGT from saved file at ~/Lockbox/.umls_auth_tgt.txt and makes API call to retrieve one if it is expired or the file does not exist

        if (!file.exists("~/Lockbox/.umls_auth_tgt.txt")) {
                tgt_resp <-
                        system(
                                paste0("curl -X POST https://utslogin.nlm.nih.gov/cas/v1/api-key -H 'content-type: application/x-www-form-urlencoded' -d apikey=", Sys.getenv("nih_api_key")),
                                intern = TRUE)

                TGT <- stringr::str_replace_all(tgt_resp, "(.*TGT Created.*api-key[/]{1})(TGT[-]{1}.*?)([\"]{1}.*)", "\\2")

                cat(paste(mirCat::stamp_this(), "\t", TGT), file = "~/Lockbox/.umls_auth_tgt.txt")
        } else {
                most_recent_TGT <- readr::read_tsv("~/Lockbox/.umls_auth_tgt.txt", col_names = c("TIMESTAMP", "TGT"), col_types = c("Tc"))
                if (lubridate::make_difftime((lubridate::ymd_hms(mirCat::stamp_this()) - most_recent_TGT$TIMESTAMP), units = "hours") >= 8) {
                        tgt_resp <-
                                system(
                                        paste0("curl -X POST https://utslogin.nlm.nih.gov/cas/v1/api-key -H 'content-type: application/x-www-form-urlencoded' -d apikey=", Sys.getenv("nih_api_key")),
                                        intern = TRUE)

                        TGT <- stringr::str_replace_all(tgt_resp, "(.*TGT Created.*api-key[/]{1})(TGT[-]{1}.*?)([\"]{1}.*)", "\\2")

                        cat(paste(mirCat::stamp_this(), "\t", TGT), file = "~/Lockbox/.umls_auth_tgt.txt")
                } else {
                        TGT <- most_recent_TGT$TGT
                }
        }

        ##Using the TGT, making a second call for a SERVICE TICKET from saved file at ~/Lockbox/.umls_auth_service_ticket.txt and makes API call to retrieve one if it is expired or the file does not exist
        if (!file.exists("~/Lockbox/.umls_auth_service_ticket.txt")) {
                SERVICE_TICKET <-
                        system(paste0(
                                "curl -X POST https://utslogin.nlm.nih.gov/cas/v1/tickets/", TGT, " -H 'content-type: application/x-www-form-urlencoded' -d service=http%3A%2F%2Fumlsks.nlm.nih.gov"),
                               intern = TRUE)

                cat(paste(mirCat::stamp_this(), "\t", SERVICE_TICKET), file = "~/Lockbox/.umls_auth_service_ticket.txt")
                return(SERVICE_TICKET)
        } else {
                most_recent_SERVICE_TICKET <- readr::read_tsv("~/Lockbox/.umls_auth_service_ticket.txt", col_names = c("TIMESTAMP", "SERVICE_TICKET"), col_types = c("Tc"))
                if (lubridate::make_difftime((lubridate::ymd_hms(mirCat::stamp_this()) - most_recent_SERVICE_TICKET$TIMESTAMP), units = "minutes") >= 4) {
                        SERVICE_TICKET <-
                                system(paste0(
                                        "curl -X POST https://utslogin.nlm.nih.gov/cas/v1/tickets/", TGT, " -H 'content-type: application/x-www-form-urlencoded' -d service=http%3A%2F%2Fumlsks.nlm.nih.gov"),
                                       intern = TRUE)

                        cat(paste(mirCat::stamp_this(), "\t", SERVICE_TICKET), file = "~/Lockbox/.umls_auth_service_ticket.txt")
                        return(SERVICE_TICKET)
                } else {
                        SERVICE_TICKET <- most_recent_SERVICE_TICKET$SERVICE_TICKET
                        return(SERVICE_TICKET)
                }
        }
}
