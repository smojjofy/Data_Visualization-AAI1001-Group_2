# 01_data_cleaning.R
# Purpose: Load and validate the energy dataset, then export a cleaned data file.

library(here)
library(readr)
library(dplyr)

input_path <- here("data", "energy_data.csv")
output_path <- here("data", "energy_data_clean.csv")

raw_data <- read_csv(input_path, show_col_types = FALSE)

expected_cols <- c("Country", "Dimension", "Category", "Percentage")
stopifnot(all(expected_cols %in% colnames(raw_data)))
stopifnot(!anyNA(raw_data$Country))
stopifnot(!anyNA(raw_data$Dimension))
stopifnot(!anyNA(raw_data$Category))
stopifnot(!anyNA(raw_data$Percentage))

clean_data <- raw_data %>%
  mutate(
    Country = as.factor(Country),
    Dimension = as.factor(Dimension),
    Category = as.factor(Category),
    Percentage = as.numeric(Percentage)
  )

# Validate normalized percentages if present
if (all(c("Country", "Dimension", "Percentage") %in% colnames(clean_data))) {
  pct_check <- clean_data %>%
    group_by(Country, Dimension) %>%
    summarise(total = sum(Percentage, na.rm = TRUE), .groups = "drop")
  stopifnot(all(abs(pct_check$total - 100) < 1e-6))
}

write_csv(clean_data, output_path)
message("Clean data saved to: ", output_path)
