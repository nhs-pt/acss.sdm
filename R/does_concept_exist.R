#' @export
does_concept_exist <- function(x) {

  response <- as_response(x, type = 'concept')

  html_text <- httr::content(response, 'text', encoding = 'UTF-8')
  html_text2 <- rvest::read_html(html_text)

  response <-
    rvest::html_elements(html_text2, xpath = '//*[@id="MainContent_lbl_BI"]') %>%
    rvest::html_text2()

  return(!identical(response, 'Nenhum registo encontrado.'))
}

