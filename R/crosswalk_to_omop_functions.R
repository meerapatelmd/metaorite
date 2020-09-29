#' @title
#' Crosswalk To OMOP Concepts
#'
#' @description
#' These functions provide avenues for crosswalking to the OMOP Vocabulary.
#'
#' @name crosswalk_to_omop_functions
#' @keywords internal
NULL


#' @title
#' Crosswalk Between Semantic Type and OMOP Domain Id
#'
#' @details
#' Note that this crosswalk is subjective and is constrained to the Observation, Device, Drug, Procedure, and Measurement domains only. If a Semantic Type is not applicable to OMOP, such as Fish and Reptile Semantic Types, they are given a Domain Id of NA. It is also important to note that the mappings between Semantic Type and OMOP Domain Id can be 1 to many.
#'
#' @seealso
#'  \code{\link[tibble]{tribble}}
#' @rdname get_semantic_type_to_domain_id
#' @export
#' @importFrom tibble tribble

get_semantic_type_to_domain_id <-
        function() {

                x <-
                tibble::tribble(~sty, ~domain_id,
                                "Machine Activity", NA,
                                "Conceptual Entity", NA,
                                "Body Space or Junction", "Observation",
                                "Medical Device", "Device",
                                "Molecular Function", "Observation",
                                "Health Care Related Organization", "Observation",
                                "Research Activity", "Observation",
                                "Immunologic Factor","Observation",
                                "Activity",NA,
                                "Amino Acid Sequence", "Observation",
                                "Anatomical Abnormality", "Observation",
                                "Chemical", "Drug",
                                "Disease or Syndrome", "Observation",
                                "Receptor", "Observation",
                                "Event", "Observation",
                                "Classification", NA,
                                "Social Behavior", "Observation",
                                "Pharmacologic Substance", "Drug",
                                "Carbohydrate Sequence", NA,
                                "Professional or Occupational Group","Observation",
                                "Plant", NA,
                                "Therapeutic or Preventive Procedure", "Procedure",
                                "Clinical Drug", "Drug",
                                "Anatomical Structure", "Observation",
                                "Nucleic Acid, Nucleoside, or Nucleotide", "Observation",
                                "Fungus", NA,
                                "Physiologic Function", "Observation",
                                "Professional Society", NA,
                                "Biologically Active Substance", "Drug",
                                "Embryonic Structure", "Observation",
                                "Age Group", "Observation",
                                "Genetic Function", "Observation",
                                "Mental Process", "Observation",
                                "Research Device", "Device",
                                "Organism Attribute", "Measurement",
                                "Physical Object", NA,
                                "Fully Formed Anatomical Structure", "Observation",
                                "Health Care Activity", NA,
                                "Cell Function", "Observation",
                                "Drug Delivery Device", "Device",
                                "Language", "Observation",
                                "Functional Concept", "Observation",
                                "Bird", NA,
                                "Gene or Genome", "Observation",
                                "Regulation or Law", NA,
                                "Quantitative Concept", "Measurement",
                                "Hormone", "Observation",
                                "Eukaryote", NA,
                                # Overlap
                                "Clinical Attribute", "Observation",
                                "Clinical Attribute", "Measurement",
                                "Hazardous or Poisonous Substance", NA,
                                "Food", "Observation",
                                "Geographic Area", "Observation",
                                "Intellectual Product", "Observation",
                                "Body Substance", "Observation",
                                "Biologic Function", "Observation",
                                "Mental or Behavioral Dysfunction", "Observation",
                                "Temporal Concept", "Observation",
                                "Mammal", NA,
                                "Organism Function", "Observation",
                                "Body System", "Observation",
                                "Neoplastic Process", "Observation",
                                "Patient or Disabled Group", NA,
                                "Vitamin", "Drug",
                                "Antibiotic", "Drug",
                                "Self-help or Relief Organization", NA,
                                "Governmental or Regulatory Activity", "Observation",
                                "Cell Component", "Observation",
                                "Molecular Sequence", "Observation",
                                "Idea or Concept", NA,
                                "Virus", "Observation",
                                "Reptile", NA,
                                "Cell or Molecular Dysfunction", "Observation",
                                "Organization",NA,
                                "Acquired Abnormality", "Observation",
                                "Manufactured Object", NA,
                                "Entity", NA,
                                "Daily or Recreational Activity", "Observation",
                                "Laboratory Procedure", "Measurement",
                                "Substance", NA,
                                "Pathologic Function", "Observation",
                                "Indicator, Reagent, or Diagnostic Aid", "Device", #Device used in care delivery
                                "Group Attribute", "Observation",
                                "Congenital Abnormality", "Observation",
                                "Tissue", "Observation",
                                "Organ or Tissue Function", "Observation",
                                "Organic Chemical", "Drug",
                                "Family Group", NA,
                                "Inorganic Chemical", "Drug",
                                "Chemical Viewed Functionally", "Drug",
                                "Animal", NA,
                                "Phenomenon or Process", "Observation",
                                "Finding", "Observation",
                                "Group", NA,
                                "Vertebrate", NA,
                                "Experimental Model of Disease", NA,
                                "Sign or Symptom", "Observation",
                                "Body Location or Region", "Observation",
                                "Organism", "Observation",
                                "Individual Behavior", "Observation",
                                "Population Group", "Observation",
                                "Amphibian", NA,
                                "Biomedical or Dental Material", "Device",
                                "Enzyme", "Observation",
                                "Spatial Concept", "Observation",
                                "Bacterium", "Observation",
                                "Qualitative Concept", NA,
                                "Occupational Activity", "Observation",
                                "Laboratory or Test Result", "Measurement",
                                "Fish", NA,
                                "Diagnostic Procedure", "Procedure",
                                "Human-caused Phenomenon or Process", NA,
                                "Environmental Effect of Humans", NA,
                                "Educational Activity", NA,
                                "Molecular Biology Research Technique", "Measurement",
                                "Archaeon", NA,
                                "Amino Acid, Peptide, or Protein", "Observation",
                                "Nucleotide Sequence", "Observation",
                                "Behavior", NA,
                                "Element, Ion, or Isotope", "Procedure",
                                "Injury or Poisoning", NA,
                                "Natural Phenomenon or Process", NA,
                                "Occupation or Discipline", NA,
                                "Human", NA,
                                "Biomedical Occupation or Discipline", NA,
                                "Body Part, Organ, or Organ Component", "Observation",
                                "Cell",  "Observation",
                                "Chemical Viewed Structurally", NA)

                if (any(!(x$domain_id %in% c(NA, "Observation","Device","Drug","Procedure","Measurement")))) {

                        warning("Unrecognized domain_id in output")
                }

                x

        }
