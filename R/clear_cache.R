#' Clear acss.sdm cache of memoised functions
#'
#' acss.sdm uses memoised functions for the GET request. Use this function to
#' reset the cache.
#'
#' @return Returns a logical value, indicating whether the resetting of the
#'   cache was successful (\code{TRUE}) or not  \code{FALSE}.
#'
#' @export
clear_cache <- function() {
  memoise::forget(mget)
}
