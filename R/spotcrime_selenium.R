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
remDr$setTimeout(type = "page load", milliseconds = 60000)
remDr$navigate("https://spotcrime.com/")

# Go log in

# Get state hrefs
state_anchors <- remDr$navigate("https://spotcrime.com/browse-by-state")
state_anchors <- remDr$findElements(using = "tag name", value = "a")
if (exists("state_hrefs")) rm(state_hrefs)
for (i in 1:length(state_anchors)) {
  href <- state_anchors[[i]]$getElementAttribute("href")[[1]]
  if (stringr::str_detect(href, "https://spotcrime.com/[A-Z][A-Z]$")) {
    if (!exists("state_hrefs")) {
      state_hrefs <- href
    } else {
      state_hrefs <- c(state_hrefs, href)
    }
  }
}
readr::write_lines(state_hrefs, "data-raw/state_hrefs.txt")

# Get area hrefs
if (exists("area_hrefs")) rm(area_hrefs)
if (exists("area_anchors")) rm(area_anchors)
#for (i in 1:length(state_hrefs)) {
for (i in 33:51) {
  area_url <- paste0(state_hrefs[i])
  print(area_url)
  area_anchors <- remDr$navigate(area_url)
  area_anchors <- remDr$findElements(using = "tag name", value = "a")
  for (j in 1:length(area_anchors)) {
    href <- area_anchors[[j]]$getElementAttribute("href")[[1]]
    if (stringr::str_detect(href, paste0(area_url, "/.+"))) {
      if (!exists("area_hrefs")) {
        area_hrefs <- href
      } else {
        area_hrefs <- c(area_hrefs, href)
      }
    }
  }
}
area_hrefs_unq <- unique(area_hrefs)
area_hrefs_unq_dt <- data.table(area_href = area_hrefs)
readr::write_csv(area_hrefs_unq_dt, "data-raw/area_hrefs.csv")

# Get archive hrefs
if (exists("archive_hrefs")) rm(archive_hrefs)
if (exists("archive_anchors")) rm(archive_anchors)
for (i in 1:length(area_hrefs)) {
  archive_url <- paste0(area_hrefs[i], "/daily-archive")
  archive_anchors <- remDr$navigate(archive_url)
  archive_anchors <- remDr$findElements(using = "tag name", value = "a")
  for (j in 1:length(archive_anchors)) {
    href <- archive_anchors[[j]]$getElementAttribute("href")[[1]]
    if (stringr::str_detect(href, "daily-archive/[0-9]")) {
      if (!exists("archive_hrefs")) {
        archive_hrefs <- href
      } else {
        archive_hrefs <- c(archive_hrefs, href)
      }
    }
  }
}

# Get crime hrefs
if (exists("archive_day_hrefs")) rm(archive_day_hrefs)
if (exists("archive_day_anchors")) rm(archive_day_anchors)
for (i in 1:length(archive_hrefs)) {
  archive_day_url <- archive_hrefs[i]
  archive_day_anchors <- remDr$navigate(archive_day_url)
  archive_day_anchors <- remDr$findElements(using = "tag name", value = "a")
  for (j in 1:length(archive_day_anchors)) {
    href <- archive_day_anchors[[j]]$getElementAttribute("href")[[1]]
    if (stringr::str_detect(href, "/crime/.+")) {
      if (!exists("archive_day_hrefs")) {
        archive_day_hrefs <- href
      } else {
        archive_day_hrefs <- c(archive_day_hrefs, href)
      }
    }
  }
}

remDr$find


remDr$navigate("https://spotcrime.com/VA/Arlington/daily-archive")

page_links <- remDr$findElements(using = "tag name", value = "a")

if (exists("archive_links")) rm(archive_links)
for (i in 1:length(page_links)) {
  link <- page_links[[i]]$getElementAttribute("href")[[1]]
  if (stringr::str_detect(link, "daily-archive/[0-9]")) {
    if (!exists("archive_links")) {
      archive_links <- link
    } else {
      archive_links <- c(archive_links, link)
    }
  }
}



src <- remDr$getPageSource()
readr::write_lines(src, "data-raw/va_arlington_20211026.html")

links <- remDr$findElement(using = "tag name", value = "a")

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
