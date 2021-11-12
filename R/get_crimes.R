get_crimes <- function(crime_cards) {
  for (i in 1:length(crime_cards)) {
    url <- rvest::html_attr(crime_cards[[i]], "href")
    crime <- rvest::html_elements(crime_cards[[i]], ".city-page__crime-card-title") %>% html_text2()
    date <- rvest::html_elements(crime_cards[[i]], ".city-page__crime-card-date") %>% html_text2()
    address <- rvest::html_elements(crime_cards[[i]], ".city-page__crime-card-address") %>% html_text2()
    dt <- data.table::data.table(url, crime, date, address)
    if (!exists("dt_out")) {
      dt_out <- dt
    } else {
      dt_out <- data.table::rbindlist(list(dt_out, dt))
    }
  }
  dt_out$area <- gsub("https://spotcrime.com/", "", locale_url) 
  dt_out
}