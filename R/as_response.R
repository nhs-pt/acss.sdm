type_to_flag <- function(x = NULL) {

  pars <- c('id_con', 'id')
  types <- c('concept', 'indicator')

  map <- rlang::set_names(pars, nm = types)

  flags <- map[x]
  names(flags) <- NULL

  return(flags)
}

as_response <- function(x, type = c('concept', 'indicator')) {

  if (methods::is(x, 'response')) {
    # If `x` is already a httr::GET response, then nothing
    # to be done, just return.
    return(x)
  } else
  {
    # Otherwise, take `x` to be an id and go fetch a response.
    type <- rlang::arg_match(type)
    flag <- type_to_flag(type)
    url <- glue::glue('{sdm_server()}/bi.aspx?{flag}={x}')
    return(get(url))
  }
}
