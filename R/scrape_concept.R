#' @export
concept <- function(id = vector('character'), key = vector('character'), value = vector('character')) {
  tibble::tibble(id = id, key = key, value= value)
}


scrape_concept_header <- function(x) {

  response <- as_response(x, type = 'concept')

  html_text <- httr::content(response, 'text', encoding = 'UTF-8')
  html_text2 <- rvest::read_html(html_text)

  xpath <- '//*[@id="MainContent_lbl_BI"]/div/table/tr[1]/td/div/table/tr[{i}]/td'

  i <- 1 # row 1, `i` gets replaced in `xpath`
  row1 <- rvest::html_elements(html_text2, xpath = glue::glue(xpath)) %>% rvest::html_text2()

  i <- 2 # row 2
  row2 <- rvest::html_elements(html_text2, xpath = glue::glue(xpath)) %>% rvest::html_text2()
  tibble::tibble(id = row1[1], # concept id, e.g., '435'.
                 key = row1[2], # header fields: `Conceito`
                 value = row2[1] # value
  )
}

scrape_concept <- function(x) {

  # Create an empty concept object.
  empty_concept <- concept()

  # Extract an xml_nodeset object from the response where each element is an
  # html table.
  html_tables <- concept_tables(x)
  n_tables <- length(html_tables)

  # If we find ourselves in the awkward situation that there are no tables, then
  # return the empty indicator object.
  if(length(html_tables) < 1L) return(empty_concept)

  # `scraped_tables` will be a list of tibbles, each tibble being the result of
  # scraping an html table. For now we just pre-allocate it.
  scraped_tables <- vector(mode = "list", length = n_tables)

  # Now let us scrape every table in turn.
  for(i in seq_len(n_tables)) {

    # The first table, i.e., the header, is scraped differently from the other
    # tables.
    if(i == 1) {
      scraped_tables[[i]] <- scrape_concept_header(x)
    } else {
      scraped_tables[[i]] <- scrape_default_table(html_tables[i])
    }
  }

  scraped_tables %>%
    dplyr::bind_rows() %>% # Bind all tibbles together into one big tibble
    tidyr::fill('id', .direction = 'down')
}

concept_tables <- function(x) {

  response <- as_response(x, type = 'concept')

  html_text <- httr::content(response, 'text', encoding = 'UTF-8')
  html_text2 <- rvest::read_html(html_text)
  xpath <- '//*[@id="MainContent_lbl_BI"]/div/table/tr/td/div/table'

  rvest::html_elements(html_text2, xpath = xpath)

}
