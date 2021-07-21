get_indicator <- function(x, wait = 0, warnings = TRUE) {

  if(!rlang::is_integerish(x)) stop('`x` must be integerish.')

  Sys.sleep(time = wait)

  if(does_indicator_exist(x)) {
    return(scrape_indicator(x))
  } else {
    if(warnings) {
      msg <- glue::glue('indicator {x} not found at the SDM server!')
      warning(msg)
    }
    # When no indicator is found return an empty indicator object (tibble with
    # no rows)
    return(indicator())
  }
}

#' @export
get_indicators <- function(x, wait = 0, warnings = TRUE) {

  purrr::map_dfr(x, get_indicator, wait, warnings)
}
