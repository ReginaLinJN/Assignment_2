# Assignment_2

# Poverty Statistics Dashboard

This project provides an interactive dashboard to explore poverty statistics worldwide, using data sourced from the World Bank API.

------------------------------------------------------------------------

## Features

1.  **Data Collection**:
    -   Automatically fetches global poverty statistics from 1981 to 2022 using the World Bank API.
2.  **Data Cleaning**:
    -   Processes and cleans the data by extracting relevant fields, handling missing values, and structuring it for analysis.
3.  **Interactive Visualization**:
    -   Includes three types of visualizations (bar chart, line chart, scatter plot) to explore trends in poverty rates across countries and time.

------------------------------------------------------------------------

### **Code Explanation**

#### **1. Data Fetching and Cleaning**

-   **Script**: `SOCS0100.R`

-   **Steps**:

    1.  Define the API endpoint and query parameters.

    2.  Fetch data from the World Bank API.

    3.  Extract and clean the relevant fields (`country`, `year`, and `value`).

    4.  Filter out rows with missing values to ensure clean data for analysis.

#### **2. Interactive Visualization**

-   **Script**: `app.R`

-   **Steps**:

    1.  Use the Shiny framework to build a user interface (`ui`) and server logic (`server`).

    2.  Include reactive filters for countries and years, allowing users to explore data dynamically.

    3.  Implement three visualization types (bar, line, and scatter plots) using `ggplot2`.
