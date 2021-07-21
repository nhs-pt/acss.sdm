get_concept <- function(x, wait = 0, warnings = TRUE) {

  if(!rlang::is_integerish(x)) stop('`x` must be integerish.')

  Sys.sleep(time = wait)

  if(does_concept_exist(x)) {
    return(scrape_concept(x))
  } else {
    if(warnings) {
      msg <- glue::glue('concept {x} not found at the SDM server!')
      warning(msg)
    }
    # When no indicator is found return an empty indicator object (tibble with
    # no rows)
    return(concept())
  }
}

#' @export
get_concepts <- function(x, wait = 0, warnings = TRUE) {

  purrr::map_dfr(x, get_concept, wait, warnings)
}
