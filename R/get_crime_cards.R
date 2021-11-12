get_crime_cards <- function(locale_url = "https://spotcrime.com/VA/Alexandria/daily-archive/2021-11-10") {
  session <- get_session()
  url <- locale_url
  cards <- rvest::session_jump_to(session, url) %>%
    rvest::html_elements(".city-page__crime-card")
}


