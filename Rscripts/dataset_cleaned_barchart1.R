library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(magrittr)
# Set the path to your CSV file
file_paths <- c("../cleaned_datasets/202212-divvy-tripdata.csv", 
                "../cleaned_datasets/202301-divvy-tripdata.csv", 
                "../cleaned_datasets/202302-divvy-tripdata.csv")
# Create an empty data frame to store the data
merged_data <- data.frame()

# Loop through each file path and read the CSV file into a temporary data frame
for (file_path in file_paths) {
  temp_data <- read.csv(file_path)
  # Append the temporary data frame to the combined data frame
  # temp_data$started_at <- as.Date(temp_data$started_at, format = "%Y-%m")
  merged_data <- rbind(merged_data, temp_data[, c("started_at","rideable_type")])
}

final_plot <- merged_data %>%
  select(rideable_type, started_at) %>%
  arrange(started_at) %>%
  mutate(rideable_type = factor(rideable_type, levels = c("classic_bike", "docked_bike", "electric_bike")),
         started_at = format(ymd_hms(started_at), "%Y\n%b")) %>%
  ggplot(aes(x = started_at, fill = rideable_type)) +
  geom_bar(position = "fill") +
  # scale_x_discrete(labels = format(merged_data$started_at, format = "%Y\n%b")) +
  scale_y_continuous(labels = percent_format()) +
  scale_fill_manual(values = c("#311B92", "#009688", "#0091EA"),
                    name = "Ride Types",
                    labels = c("Classic bike", "Docked bike", "Electric bike")) +
  labs(title = "Total Monthly Rideable Types by Proportion",
       x = "Month",
       y = "Proportion",
       fill = "Rideable Type")
ggsave("rt_by_month.pdf", final_plot, width = 8, height = 6)
