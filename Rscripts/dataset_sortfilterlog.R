library(tidyverse)
library(dplyr)
source("dataset_logger.R")
# Set the path to your CSV file
file_path <- "../original_datasets/"

# Get a list of all CSV files in the subdirectories of the parent directory
file_names <- list.files(file_path, pattern = "\\.csv$",
                         recursive = TRUE, full.names = TRUE)

# Loop through each CSV file and display its contents
filechecker <- function() {
  if (length(file_names) == 0){
    cat("Error -  File is empty")
    quit(save = "no", status = 1L, runLast = FALSE)
  }
}
checking <- filechecker()
for (file_name in file_names) {
  current_full_path <- normalizePath(file_name)
  #csv_data <- read.csv(current_full_path)
  #csv_data2 <- csv_data %>%
  #select(rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual) %>%
  #filter_all(all_vars(!is.na(.) & !(. %in% c("", " ")))) %>%
  #arrange(started_at)
  cat(current_full_path)
  cat("\n\n")
  # Construct new file path
  new_path <- gsub("original_datasets", "cleaned_datasets", current_full_path)
  if (!file.exists(dirname(new_path))) {
    dir.create(dirname(new_path))
  }
  create_log(message = "Filtered & Sorted file", file_path = new_path)
  #write.csv(csv_data2, new_path, row.names = FALSE)
  cat(new_path)
  cat("\n\n\n\n\n")
}
