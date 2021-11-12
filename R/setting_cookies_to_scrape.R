
state_links <- get_state_links("VA")
archive_links <- get_archive_links(state_links[2])
crime_cards <- get_crime_cards(archive_links[1])
crimes <- get_crimes(crime_cards)
