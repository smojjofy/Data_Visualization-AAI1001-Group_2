# 03_visualization.R
# Purpose: Create visualizations from the cleaned dataset.

library(here)
library(readr)
library(dplyr)
library(ggplot2)
library(patchwork)

input_path <- here("data", "energy_data_clean.csv")
output_path <- here("images", "energy_consumption_plot.png")

clean_data <- read_csv(input_path, show_col_types = FALSE)

plot <- clean_data %>%
  ggplot(aes(x = Country, y = Percentage, fill = Category)) +
  geom_col(position = "fill") +
  facet_wrap(~ Dimension, scales = "free_x", ncol = 1) +
  scale_y_continuous(labels = scales::percent_format(scale = 1)) +
  theme_minimal() +
  labs(
    title = "Energy Consumption Mix by Fuel and Sector",
    y = "Percentage share",
    x = "Country",
    fill = "Category"
  )

ggsave(output_path, plot, width = 14, height = 8)
message("Plot saved to: ", output_path)
