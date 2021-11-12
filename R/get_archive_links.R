get_archive_links <- function(locale_url) {
  session <- get_session()
  url <- paste0(locale_url, "/daily-archive")
  archive_url_rel <- rvest::session_jump_to(session, url) %>%
    html_elements(".crime-records__daily-blotter-option") %>%
    html_attr("href")
  paste0("https://spotcrime.com", archive_url_rel)
}

