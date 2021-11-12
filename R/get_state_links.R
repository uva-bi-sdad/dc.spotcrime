get_state_links <- function(state_abbrv = "VA") {
  session <- get_session()
  url <- paste0("https://spotcrime.com/", state_abbrv, "/")
  locale_url_rel <- rvest::session_jump_to(session, url) %>%
    html_elements(".state-page__city-btn") %>%
    html_attr("href")
  paste0("https://spotcrime.com", locale_url_rel)
}