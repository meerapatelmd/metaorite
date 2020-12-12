#' @title
#' Field Value Annotation Functions
#'
#' @description
#' These functions add extra fields to a dataframe that annotate the field value meaning with what is provided in the UMLS Web Documentation.
#'
#' @param data          dataframe returned from a Metathesaurus query
#'
#' @name annotation_functions
#' @keywords internal
NULL


#' @title
#' Annotate Field Values
#'
#' @inherit annotation_functions description
#' @inheritParams annotation_functions
#' @param ... (optional) Columns in the data to annotate. If missing, all available annotations are provided for every column.
#'
#' @details
#' These annotations are derived from \code{\link{doc_field_value_annotations}}
#'
#' @seealso
#'  \code{\link[dplyr]{mutate_all}},\code{\link[dplyr]{select}},\code{\link[dplyr]{mutate-joins}}
#'  \code{\link[purrr]{reduce}}
#' @rdname annotate_field_values
#' @export
#' @importFrom dplyr mutate_all select left_join inner_join
#' @importFrom purrr reduce

annotate_field_values <-
        function(data,
                 ...) {
                # converted to facilitate the join
                data <-
                        data %>%
                        dplyr::mutate_all(as.character)

                # normalize field casing
                if (missing(...)) {

                        data_fields <- toupper(colnames(data))

                } else {

                        data_fields <-
                                data %>%
                                dplyr::select(...) %>%
                                colnames() %>%
                                toupper()

                }

                field_value_annotation <- doc_field_value_annotation()
                field_value_annotation <- field_value_annotation[names(field_value_annotation) %in% data_fields]

                fields <- names(field_value_annotation)

                output <- list()

                for (i in 1:length(field_value_annotation)) {

                        annotation <- field_value_annotation[[i]]
                        field <- names(field_value_annotation)[i]
                        annotation_label <- colnames(annotation)[1]

                        colnames(annotation)[1] <- field
                        colnames(annotation) <- tolower(colnames(annotation))

                        output[[i]] <-
                                data %>%
                                dplyr::left_join(annotation)

                        names(output)[i] <- annotation_label

                }

                output %>%
                        purrr::reduce(dplyr::inner_join)

        }


#' @title
#' Annotate the SAB Field
#'
#' @inherit annotation_functions description
#' @inheritParams annotation_functions
#'
#' @details
#' The annotations used in this function are derived from \code{\link{doc_sab_annotation}}.
#' @seealso
#'  \code{\link[dplyr]{mutate}},\code{\link[dplyr]{mutate-joins}}
#' @rdname annotate_sab
#' @export
#' @importFrom dplyr mutate left_join

annotate_sab <-
        function(data) {

                if (!("sab" %in% colnames(data))) {

                        stop("'sab' not in colnames")

                }


                sab_annotation <- doc_sab_annotation()
                sab_annotation <-
                        sab_annotation %>%
                        dplyr::mutate(sab = Abbreviation)


                data %>%
                        dplyr::left_join(sab_annotation,
                                         by = "sab")


        }
