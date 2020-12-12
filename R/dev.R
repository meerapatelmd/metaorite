#' @noRd

dev_get_semantic_type_to_domain_id <-
        function(conn) {
                semantic_types <-
                        c('Machine Activity',
                          'Conceptual Entity',
                          'Body Space or Junction',
                          'Medical Device',
                          'Molecular Function',
                          'Health Care Related Organization',
                          'Research Activity',
                          'Immunologic Factor',
                          'Activity',
                          'Amino Acid Sequence',
                          'Anatomical Abnormality',
                          'Chemical',
                          'Disease or Syndrome',
                          'Receptor',
                          'Event',
                          'Classification',
                          'Social Behavior',
                          'Pharmacologic Substance',
                          'Carbohydrate Sequence',
                          'Professional or Occupational Group',
                          'Plant',
                          'Therapeutic or Preventive Procedure',
                          'Clinical Drug',
                          'Anatomical Structure',
                          'Nucleic Acid, Nucleoside, or Nucleotide',
                          'Fungus',
                          'Physiologic Function',
                          'Professional Society',
                          'Biologically Active Substance',
                          'Embryonic Structure',
                          'Age Group',
                          'Genetic Function',
                          'Mental Process',
                          'Research Device',
                          'Organism Attribute',
                          'Physical Object',
                          'Fully Formed Anatomical Structure',
                          'Health Care Activity',
                          'Cell Function',
                          'Drug Delivery Device',
                          'Language',
                          'Functional Concept',
                          'Bird',
                          'Gene or Genome',
                          'Regulation or Law',
                          'Quantitative Concept',
                          'Hormone',
                          'Eukaryote',
                          'Clinical Attribute',
                          'Hazardous or Poisonous Substance',
                          'Food',
                          'Geographic Area',
                          'Intellectual Product',
                          'Body Substance',
                          'Biologic Function',
                          'Mental or Behavioral Dysfunction',
                          'Temporal Concept',
                          'Mammal',
                          'Organism Function',
                          'Body System',
                          'Neoplastic Process',
                          'Patient or Disabled Group',
                          'Vitamin',
                          'Antibiotic',
                          'Self-help or Relief Organization',
                          'Governmental or Regulatory Activity',
                          'Cell Component',
                          'Molecular Sequence',
                          'Idea or Concept',
                          'Virus',
                          'Reptile',
                          'Cell or Molecular Dysfunction',
                          'Organization',
                          'Acquired Abnormality',
                          'Manufactured Object',
                          'Entity',
                          'Daily or Recreational Activity',
                          'Laboratory Procedure',
                          'Substance',
                          'Pathologic Function',
                          'Indicator, Reagent, or Diagnostic Aid',
                          'Group Attribute',
                          'Congenital Abnormality',
                          'Tissue',
                          'Organ or Tissue Function',
                          'Organic Chemical',
                          'Family Group',
                          'Inorganic Chemical',
                          'Chemical Viewed Functionally',
                          'Animal',
                          'Phenomenon or Process',
                          'Finding',
                          'Group',
                          'Vertebrate',
                          'Experimental Model of Disease',
                          'Sign or Symptom',
                          'Body Location or Region',
                          'Organism',
                          'Individual Behavior',
                          'Population Group',
                          'Amphibian',
                          'Biomedical or Dental Material',
                          'Enzyme',
                          'Spatial Concept',
                          'Bacterium',
                          'Qualitative Concept',
                          'Occupational Activity',
                          'Laboratory or Test Result',
                          'Fish',
                          'Diagnostic Procedure',
                          'Human-caused Phenomenon or Process',
                          'Environmental Effect of Humans',
                          'Educational Activity',
                          'Molecular Biology Research Technique',
                          'Archaeon',
                          'Amino Acid, Peptide, or Protein',
                          'Nucleotide Sequence',
                          'Behavior',
                          'Element, Ion, or Isotope',
                          'Injury or Poisoning',
                          'Natural Phenomenon or Process',
                          'Occupation or Discipline',
                          'Human',
                          'Biomedical Occupation or Discipline',
                          'Body Part, Organ, or Organ Component',
                          'Cell',
                          'Chemical Viewed Structurally')

        for (i in 1:length(semantic_types)) {

                        semantic_type <- semantic_types[i]

                        x <-
                                pg13::query(conn = conn,
                                            sql_statement = SqlRender::render(
                                                    "
                                                                with cui_sample AS (
                                                                SELECT DISTINCT m.cui
                                                                FROM mth.mrsty s
                                                                LEFT JOIN mth.mrconso m
                                                                ON m.cui = s.cui
                                                                WHERE s.sty = '@semantic_type'
                                                    )
                                                    SELECT m.*
                                                    FROM cui_sample
                                                    LEFT JOIN mth.mrconso m
                                                    ON m.cui = cui_sample.cui
                                                    WHERE m.lat = 'ENG';",
                                                    semantic_type = semantic_type)) %>%
                                dplyr::group_by(cui) %>%
                                dplyr::summarize_at(vars(str), function(x) paste(unique(tolower(x)), collapse = ", "))

                        print(semantic_type)
                        print(x)

                        secretary::press_enter()
        }

}
