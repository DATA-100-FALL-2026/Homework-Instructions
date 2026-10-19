# ============================================================
# scrape-measures.R
# HW 06: Scraping ballot measure campaign finance data
# ============================================================
# Fill in each blank marked with ___
# ============================================================
#
# NOTE: Ballotpedia blocks automated requests from cloud servers
# (the same kind of block that affects IMDB in AE 09), which means
# read_html() can't reach ballotpedia.org directly from RStudio
# Cloud / Posit Cloud. To work around this, we've pre-saved the
# five pages you need as local HTML files in the `data-raw/`
# folder of your repo:
#
#   data-raw/ballotpedia-2016.html
#   data-raw/ballotpedia-2018.html
#   data-raw/ballotpedia-2020.html
#   data-raw/ballotpedia-2022.html
#   data-raw/ballotpedia-2024.html
#
# read_html() works exactly the same way on a local file path as
# it does on a URL - the only thing that changes below is WHAT we
# hand it (a file path instead of a web address). Everything else
# about scraping - CSS selectors, html_table(), bind_rows() - works
# identically either way.

# 1. Load packages --------------------------------------------
library(tidyverse)
library(rvest)

# 2. Write a function that scrapes ONE year's page -------------
# The page has TWO tables that share identical columns (one for
# citizen-initiated measures, one for legislative/other referred
# measures) - use SelectorGadget on the live site in your browser
# to find the CSS selector that matches BOTH of them, then combine
# the two tables into one.
scrape_measures <- function(file) {

  page <- read_html(file)

  # This selector should match BOTH tables on the page
  tables <- page %>%
    html_elements("___") %>%
    html_table()

  # tables is a list of 2 data frames (identical columns) -
  # stack them into one data frame
  df <- bind_rows(___)

  df <- df %>%
    rename(
      measure    = `Ballot Measure`,
      total      = `Total Contributions`,
      support    = `___`,
      opposition = `___`,
      outcome    = Outcome
    ) %>%
    mutate(
      # The year isn't a column on the page - it's embedded in the
      # FILENAME instead (e.g. "data-raw/ballotpedia-2024.html").
      # Use str_sub() to grab the last 4 characters before ".html"
      # (positions -9 to -6).
      year = str_sub(___, -___, -___)
    )

  df
}

# 3. Test your function on a few years --------------------------
file_2024 <- "___"
file_2020 <- "___"
file_2016 <- "___"

scrape_measures(file_2024)
scrape_measures(file_2020)
scrape_measures(file_2016)
# Does the output look right? Check: measure, total, support,
# opposition, outcome, and year columns should all be present.

# 4. Build the vector of ALL files we want ------------------------
# Ballot measures are decided in general elections, so this page
# only exists for even years, and the file-naming pattern used here
# is only consistent starting in 2016 (earlier years use a
# different naming pattern on the site, so we won't include them).
years <- c(___, ___, ___, ___, ___)  # 2016 through 2024, even years only

files <- paste0(
  "data-raw/ballotpedia-",
  ___,
  ".html"
)

# 5. Scrape all years with map_dfr() ------------------------------
measures_all <- map_dfr(___, scrape_measures)

# 6. Check your work -----------------------------------------------
nrow(measures_all)   # should be several hundred rows
head(measures_all)

# 7. Save your data --------------------------------------------------
# Hint: this creates the data folder if it doesn't already exist
dir.create("data", showWarnings = FALSE)
write_csv(measures_all, "___")
