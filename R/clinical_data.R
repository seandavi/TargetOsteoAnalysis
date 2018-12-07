#' load TARGET osteosarcoma data
#'
#' This loads the data from the local system.file
#' file. This file may or may not be the latest
#' version. The current verion is from 20180107.
#'
#' The clinical columns include:
#'
#' TARGET USI, Gender, Race, Ethnicity, Age at Diagnosis in Days, First Event, Time to First Event in Days, Vital Status, Overall Survival Time in Days, Year of Diagnosis, Year of Last Follow Up, Protocol, Disease at diagnosis, Metastasis site, Primary tumor site, Specific tumor site, Specific tumor side, Specific tumor region, Definitive Surgery, Primary site progression, Site of initial relapse, Time to first relapse in days, Time to first enrollment on relapse protocol in days, Time to first SMN in days, Time to death in days, Histologic response, Percent necrosis at Definitive Surgery, Relapse Type, Therapy, Comment, cohort
#'
#'
#' @references \url{ftp://caftpd.nci.nih.gov/pub/OCG-DCC/TARGET/OS/clinical/harmonized/}
#'
#' @importFrom readxl read_xlsx
#' @importFrom dplyr bind_rows
#'
#' @examples
#'
#' target_load_clinical()
#'
#' @export
target_load_clinical = function() {
  .clinical_validation_file = system.file(package='TargetOsteoAnalysis','extdata/TARGET_OS_Validation_ClinicalData_20180107.xlsx')
  .clinical_discovery_file = system.file(package='TargetOsteoAnalysis','extdata/TARGET_OS_Discovery_ClinicalData_20180618.xlsx')

  validation = readxl::read_xlsx(.clinical_validation_file, na = c('NA','None','n/a','N/A'))
  discovery  = readxl::read_xlsx(.clinical_discovery_file, na = c('NA','None','n/a', 'N/A'))
  validation$cohort = "Validation"
  discovery$cohort  = "Discovery"
  ret = dplyr::bind_rows(discovery,validation) %>%
    mutate(metastatic = !grepl( "Non-met", `Disease at diagnosis`))
  ret
}

#' convert TARGET USI to samplename
#'
#' Convert from 'TARGET-40-PALPAX' to
#' 'PALPAX'
#'
#' @param usi character() A target USI of the form "TARGET-40-ABCDEF" or "TARGET-40-ABCDEF-01A-10A"
#' @param long logical() Specify TRUE for USIs of the form "TARGET-40-ABCDEF-01A-10A" and
#'     FALSE for "TARGET-40-ABCDEF"
#'
#' @importFrom stringr str_replace
#'
#' @export
target_usi_to_samplename = function(usi, long=FALSE) {
  if(!long) return(str_replace(as.character(usi), 'TARGET-[0-9]+-',''))
  return(str_match(usi, "TARGET-40-(.*)-(.*)-(.*)")[,2])
}
