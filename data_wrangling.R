# Load packages
pacman::p_load(
  tidyverse, # Wrangling
  rio, # Import and export data
  here, # File management
  skimr, # Skim dataset
  finalfit, # Labeling
  janitor # Clean names
)


# Import dataset
df <- import(here("data", "muac.sav"))
head(df)

# Clean names
df <- clean_names(df)
head(df)

# Remove redundant columns
df <- df |>
  select(-c(
    bmi,
    bmi_groups,
    age_groups,
    height_meters,
    muac_male_groups,
    muac_females_groups
  ))