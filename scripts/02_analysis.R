# 02_analysis.R
# Purpose: Generate summary tables and comparisons from the cleaned energy dataset.

library(here)
library(readr)
library(dplyr)

input_path <- here("data", "energy_data_clean.csv")

clean_data <- read_csv(input_path, show_col_types = FALSE)

summary_table <- clean_data %>%
  group_by(Dimension, Category) %>%
  summarise(mean_value = mean(Percentage, na.rm = TRUE), .groups = "drop")

print(summary_table)

write_csv(summary_table, here("data", "summary_energy_by_category.csv"))
message("Summary table saved to data/summary_energy_by_category.csv")
