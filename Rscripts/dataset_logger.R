library(tidyverse)
library(lubridate)


create_log <- function(message,file_path) {
  # Get current time in milliseconds and time zone
  current_time <- as.numeric(Sys.time()) * 1000
  timezone <- Sys.getenv("TZ")
  # Get current date and time
  datetime <- format(Sys.time(), "%Y-%m-%d %I:%M:%S %p")

  # Get current Linux user and operating system/platform
  # Get current Linux user and operating system/platform
  user <- Sys.getenv("USER")
  system_info <- Sys.info()
  os_platform <- paste(system_info["sysname"], system_info["machine"], sep = "/")
  # Create data frame with log data
  log_data <- tibble(
    timestamp = current_time,
    datetime = datetime,
    timezone = timezone,
    message = message,
    filepath = file_path,
    user = user,
    os_platform = os_platform
  )

  # Append log data to CSV file
  if (file.exists("../Logs/log.csv")) {
    write_csv(log_data, "../Logs/log.csv", append = TRUE)
  } else {
    write_csv(log_data, "../Logs/log.csv")
  }
}
