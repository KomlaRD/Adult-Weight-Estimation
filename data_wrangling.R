# Load packages
pacman::p_load(
  tidyverse, # Wrangling
  rio, # Import and export data
  here, # File management
  skimr, # Skim dataset
  finalfit, # Labeling
  janitor, # Clean names
  DataExplorer # Data exploration
)


# Import dataset
df <- import(here("data", "muac.sav"))

# Clean names
df <- clean_names(df)

# Remove unused features
df <- df |>
  select(-c(
    bmi,
    bmi_groups,
    muac_male_groups,
    muac_females_groups,
    age_groups
  ))

# Mutate variables (Average values for double measurements)
df <- df |>
  mutate(
    height = (height_1 + height_2) / 2, # Height (cm)
    weight = (weight_1 + weight_2) / 2, # Weight (cm)
    cc = (calf_circumference_1 + calf_circumference_2) / 2, # Calf circumference (cm)
    muac = (muac_1 + muac_2) / 2 # Mid-upper arm circumference (cm)
  )

# Remove measurement variables
df <- df |>
  select(-c(
    height_1,
    height_2,
    weight_1,
    weight_2,
    muac_1,
    muac_2,
    calf_circumference_1,
    calf_circumference_2
  ))


# Mutate categorical variables
df <- df |> 
  mutate(
    # Sex
    sex = factor(sex) |> ff_label("Sex"),
    
    # Religion
    religion = factor(religion) |> ff_label("Religion"),
    
    # Educational level
    education_level = factor(education_level) |> ff_label("Educational level"),
    
    # Employment status
    employment = factor(employment) |> ff_label("Employment status")
  )


# Label numeric variables
df <- df |>
  mutate(
    bmi = (weight / (height/100) **2),
    age = ff_label(age, "Age (years"),
    height = ff_label(height, "Height (cm)"),
    weight = ff_label(weight, "Weight (kg)"),
    cc = ff_label(cc, "Calf circumference (cm)"),
    muac = ff_label(muac, "MUAC (cm)"),
    bmi = ff_label(bmi, "Body mass index (kgm-2")
  )

# Mutate bmi into categories
df <- df |>
  mutate(
    bmi_cat = case_when(
      bmi < 18.5 ~ "Underweight",
      bmi >= 18.5 & bmi <= 24.9 ~ "Normal",
      bmi >= 25.0 & bmi <= 29.9 ~ "Overweight",
      bmi >= 30.0 ~ "Obese"
    ) |> ff_label("BMI categories"),
    bmi_cat = factor(bmi_cat)
  )
    
# Skim dataset
skim(df)

# Shapiro-Wilk test
# Function to perform Shapiro-Wilk test and extract p-value
shapiro_test <- function(x) {
  shapiro_result <- shapiro.test(x)
  return(shapiro_result$p.value)
}

# Extract numeric variables from the dataset
numeric_vars <- df %>%
  select_if(is.numeric)

# Apply the Shapiro-Wilk test to each numeric variable and tidy the results
shapiro_p_values <- numeric_vars %>%
  summarise(across(everything(), ~ shapiro_test(.))) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "P_Value")

# Display the p-values
print("Shapiro values for normality testing")
print(shapiro_p_values)

## Note; None of the numeric variables are normally distributed

# Create exploratory data analysis report
create_report(df)

## Export dataset
export(df, here("data", "muac.csv"))

# Prediction using existing equation
## Crandall 
#----------------------------------------------
# Women: 64.6 + (MAC * 2.15) + (height * 0.54)
# Men: 93.2 + (MAC * 3.29) + (height * 0.43)
#----------------------------------------------


# Function for Crandall equation
crandall_weight <- function(MAC, height, gender) {
  ifelse(gender == "female",
         -64.6 + (MAC * 2.15) + (height * 0.54),
         ifelse(gender == "male",
                -93.2 + (MAC * 3.29) + (height * 0.43),
                NA)) # Returns NA for invalid gender
}

## Simplified MAC
#----------------------------------------------
# (MAC * 4) - 50
#----------------------------------------------

# Function for Simplified MAC equation
simplified_mac_weight <- function(MAC) {
  return((MAC * 4) - 50)
}


## Kokong
#----------------------------------------------
# Height (cm) - 100 OR
# 100 * (Height (m) - 1)
#----------------------------------------------

# Function for Kokong equation
kokong_weight <- function(height) {
  return(height - 100)
}


# Create vectors for predictions

## Crandall formula
df$cradall_prediction <- crandall_weight(df$muac, df$height, df$sex)

## Simplified formula
df$sim_muac <- simplified_mac_weight(df$muac)

## Kokong formula
df$kokong <- kokong_weight(df$height)


