get_session <- function() {
  rvest::session("https://spotcrime.com/", 
                 httr::set_cookies(UIDR = "1614275997",
                                   UID = "1C810496a22084a246abf171614275997"),
                 httr::add_headers(UIDR = "1614275997",
                                   UID = "1C810496a22084a246abf171614275997"))
}