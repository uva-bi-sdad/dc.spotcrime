library(RSelenium)
library(rvest)
library(data.table)

port <- 4444
ip <- "host.docker.internal"
rdBrowser <- "firefox"

remDr <- remoteDriver$new(
  remoteServerAddr = ip,
  port = port,
  browserName = rdBrowser
)

remDr$open()
remDr$setTimeout(type = "page load", milliseconds = 20000)
remDr$navigate("https://spotcrime.com/VA/Arlington/daily-archive")

links <- remDr$findElements(using = "tag name", value = "a")

print(paste0("Number of Links in the Page is ", length(links)))

if (exists("area_links")) rm(area_links)
for (i in 1:length(links)) {
  print(paste0("Name of Link# ", i, links[[i]]$getElementAttribute("href")))
  link <- links[[i]]$getElementAttribute("href")
  link_dt <- data.table(area = "Arlington", crime_link = link)
  if (!exists("area_links")) {
    area_links <- link_dt
  } else {
    area_links <- rbindlist(list(area_links, link_dt))
  }
}
area_archive_links <- area_links[crime_link %like% "/daily-archive/.+"]

remDr$navigate(area_archive_links[1, crime_link][[1]])
