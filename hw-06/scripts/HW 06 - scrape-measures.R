# ============================================================
# scrape-measures.R
# HW 06: Scraping ballot measure campaign finance data
# ============================================================
# Fill in each blank marked with ___
# ============================================================

# 1. Load packages --------------------------------------------
library(tidyverse)
library(robotstxt)
library(rvest)

# 2. Check that we're allowed to scrape this site --------------
paths_allowed("___")

# 3. Write a function that scrapes ONE year's page -------------
# The page has TWO tables that share identical columns (one for
# citizen-initiated measures, one for legislative/other referred
# measures) - use SelectorGadget to find the CSS selector that
# matches BOTH of them, then combine the two tables into one.
scrape_measures <- function(url) {

  page <- read_html(url)

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
      # URL instead (e.g. ".../Ballot_measure_campaign_finance,_2024").
      # Use str_sub() to grab the last 4 characters of the url.
      year = str_sub(___, -___, -1)
    )

  df
}

# 4. Test your function on a few years --------------------------
url_2024 <- "___"
url_2020 <- "___"
url_2016 <- "___"

scrape_measures(url_2024)
scrape_measures(url_2020)
scrape_measures(url_2016)
# Does the output look right? Check: measure, total, support,
# opposition, outcome, and year columns should all be present.

# 5. Build the vector of ALL years we want ------------------------
# Ballot measures are decided in general elections, so this page
# only exists for even years, and the URL naming pattern used here
# is only consistent starting in 2016 (earlier years use a
# different naming pattern on the site, so we won't include them).
years <- c(___, ___, ___, ___, ___)  # 2016 through 2024, even years only

urls <- paste0(
  "https://ballotpedia.org/Ballot_measure_campaign_finance,_",
  ___
)

# 6. Scrape all years with map_dfr() ------------------------------
measures_all <- map_dfr(___, scrape_measures)

# 7. Check your work -----------------------------------------------
nrow(measures_all)   # should be several hundred rows
head(measures_all)

# 8. Save your data --------------------------------------------------
# Hint: this creates the data folder if it doesn't already exist
dir.create("data", showWarnings = FALSE)
write_csv(measures_all, "___")
