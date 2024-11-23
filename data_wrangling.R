# Load packages
pacman::p_load(
  tidyverse,
  rio,
  here,
  skimr,
  finalfit
)


# Import dataset
df <- import(here("data", "muac.sav"))
head(df)

