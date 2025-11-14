# Libraries --------------------


library(azmetr)
library(cli)
library(fs)
library(dplyr)
library(glue)
library(htmltools)
library(lubridate)
library(plotly)
library(purrr)
library(readr)
library(shiny)
# library(shinyjs)
library(snakecase)
library(stringr)
library(tidyr)


# Files --------------------


# Functions. Loaded automatically at app start if in `R` folder
# source("./R/utils.R")
# source("./R/azmet_daily_data_download.R")
# source("./R/azmet_hourly_data_download.R")

# shiny::addResourcePath("shinyjs", system.file("srcjs", package = "shinyjs"))

station_list <- read_csv("azmet-station-list.csv")


# Variables --------------------

obsYears <- seq(from = 2020, to = 2022)
obsYearsInitial <- 2021
