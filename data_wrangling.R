# Load packages
pacman::p_load(
  tidyverse, # Wrangling
  rio, # Import and export data
  here, # File management
  skimr, # Skim dataset
  finalfit, # Labelling
  janitor # Clean names
)


# Import dataset
df <- import(here("data", "muac.sav"))
head(df)

# Clean names
df <- clean_names(df)