# Clean Environment
rm(list = ls())

# Load Required Libraries
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  httr,
  gtrendsR,
  ggplot2,
  ggmap,
  dplyr,
  tidyr,
  jsonlite
)

url <- "http://api.worldbank.org/v2/country/all/indicator/SI.POV.DDAY"
params <- list(
  date = "1981:2022",  # Time range
  format = "json",     # Data format
  per_page = "1000"    # Maximum results per page
)

response <- GET(url, query = params)

if (status_code(response) == 200) {
  data <- fromJSON(content(response, "text"))
  
  poverty_data <- data[[2]]
  
  poverty_data <- as_tibble(poverty_data)
  
  # Preview the data
  print(head(poverty_data))
} else {
  stop("Failed to fetch data. Please check the API request.")
}

  
  poverty_cleaned <- poverty_data %>%
    # Extract and rename relevant fields
    transmute(
      country = country$value,  # Extract the 'value' field from the nested 'country' object
      year = as.numeric(date), # Convert 'date' to numeric
      value = as.numeric(value)  # Convert 'value' to numeric
    ) %>%
    filter(!is.na(value))  # Remove rows with missing values
  