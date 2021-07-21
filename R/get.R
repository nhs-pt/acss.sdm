memoised_get <- memoise::memoise(httr::GET)

get <- function(url) memoised_get(url)

