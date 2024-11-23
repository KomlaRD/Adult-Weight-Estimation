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

# Mutate variables (Average values for double measurements)
df <- df |>
  mutate(
    height = (height_1 + height_2) / 2, # Height (cm)
    weight = (weight_1 + weight_2) / 2, # Weight (cm)
    cc = (calf_circumference_1 + calf_circumference_2) / 2, # Calf circumference (cm)
    muac = (muac_1 + muac_2) / 2 # Mid-upper arm circumference (cm)
  )

