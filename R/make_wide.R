#' @export
make_wide <- function(tbl) {

  tidyr::pivot_wider(tbl, names_from = 'key', values_from = 'value')

}
