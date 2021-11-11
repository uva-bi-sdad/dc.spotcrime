library(rvest)
library(httr)
WP <- html_session("https://spotcrime.com/VA/Arlington/daily-archive/2021-11-02", 
             set_cookies(UIDR = "1614275997",
                         UID = "1C810496a22084a246abf171614275997",
                         `_spotcrime_key` = "SFMyNTY.g3QAAAADbQAAAAtfY3NyZl90b2tlbm0AAAAYNEJwR3h3T0Y1aDg4Y3BNZEIxSl9Rb0ZmbQAAAA5sYXN0X3Bpbl9sb2dpbnQAAAANZAAKX19zdHJ1Y3RfX2QAD0VsaXhpci5EYXRlVGltZWQACGNhbGVuZGFyZAATRWxpeGlyLkNhbGVuZGFyLklTT2QAA2RheWELZAAEaG91cmEUZAALbWljcm9zZWNvbmRoAmIABdzPYQZkAAZtaW51dGVhHWQABW1vbnRoYQtkAAZzZWNvbmRhH2QACnN0ZF9vZmZzZXRhAGQACXRpbWVfem9uZW0AAAAHRXRjL1VUQ2QACnV0Y19vZmZzZXRhAGQABHllYXJiAAAH5WQACXpvbmVfYWJicm0AAAADVVRDbQAAAAp1c2VyX3Rva2VubQAAACRhMTUzZDk0Yi0wNzdkLTQ1MjMtYTFlMS00OWE5OTJjMzA2ZDM.fLieRPXLvOaLIk_T1uaj7YobzKG9htvwibvhX3joAlI",
                         `_fssid` = "ac0eb17e-dd3e-4d88-bdff-503721c94062",
                         fsbotchecked = "true"),
             add_headers(UIDR = "1614275997",
                         UID = "1C810496a22084a246abf171614275997",
                         `_spotcrime_key` = "SFMyNTY.g3QAAAADbQAAAAtfY3NyZl90b2tlbm0AAAAYNEJwR3h3T0Y1aDg4Y3BNZEIxSl9Rb0ZmbQAAAA5sYXN0X3Bpbl9sb2dpbnQAAAANZAAKX19zdHJ1Y3RfX2QAD0VsaXhpci5EYXRlVGltZWQACGNhbGVuZGFyZAATRWxpeGlyLkNhbGVuZGFyLklTT2QAA2RheWELZAAEaG91cmEUZAALbWljcm9zZWNvbmRoAmIABdzPYQZkAAZtaW51dGVhHWQABW1vbnRoYQtkAAZzZWNvbmRhH2QACnN0ZF9vZmZzZXRhAGQACXRpbWVfem9uZW0AAAAHRXRjL1VUQ2QACnV0Y19vZmZzZXRhAGQABHllYXJiAAAH5WQACXpvbmVfYWJicm0AAAADVVRDbQAAAAp1c2VyX3Rva2VubQAAACRhMTUzZDk0Yi0wNzdkLTQ1MjMtYTFlMS00OWE5OTJjMzA2ZDM.fLieRPXLvOaLIk_T1uaj7YobzKG9htvwibvhX3joAlI",
                         `_fssid` = "ac0eb17e-dd3e-4d88-bdff-503721c94062",
                         fsbotchecked = "true"))

WP$response
html_text(WP$response)
is.session(WP)
as <- session_jump_to(WP, "https://spotcrime.com/VA/Arlington/daily-archive/2021-11-02") %>% html_elements("a")

cr <- session_jump_to(WP, "https://spotcrime.com/crime/169018428-a7d8b3dfd55b414af4c4cf3ba5b903a3")
cr %>% html_elements("p")



WP2 <- html_session("https://spotcrime.com/VA/", 
                   set_cookies(UIDR = "1614275997",
                               UID = "1C810496a22084a246abf171614275997"),
                   add_headers(UIDR = "1614275997",
                               UID = "1C810496a22084a246abf171614275997"))
cr2 <- session_jump_to(WP2, "https://spotcrime.com/crime/169018428-a7d8b3dfd55b414af4c4cf3ba5b903a3")
cr2 %>% html_elements("p")
