library(tidyverse)
library(dplyr)
# Set the path to your CSV file
file_path <- "../cleaned_datasets/"

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
  # Read in the CSV file
  csv_data <- read.csv(normalizePath(file_name))
  # Display the first few rows of the CSV file
  content <- head(csv_data, n = 12)
  cat(normalizePath(file_name))
  cat("\n\n")
  print(content)
  cat("\n\n\n\n\n")
}
