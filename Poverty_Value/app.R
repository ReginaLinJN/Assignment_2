#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

ui <- fluidPage(
  titlePanel("Poverty Statistics Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Select Country:", choices = unique(poverty_cleaned$country)),
      sliderInput("year", "Select Year Range:",
                  min = min(poverty_cleaned$year),
                  max = max(poverty_cleaned$year),
                  value = c(min(poverty_cleaned$year), max(poverty_cleaned$year)),
                  step = 1)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Bar Chart", plotOutput("bar_plot")),
        tabPanel("Line Chart", plotOutput("line_plot")),
        tabPanel("Scatter Plot", plotOutput("scatter_plot"))
      )
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    poverty_cleaned %>%
      filter(country == input$country & year >= input$year[1] & year <= input$year[2])
  })
  
  # Bar Chart
  output$bar_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = value)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      theme_minimal() +
      labs(title = "Poverty Rate (Bar Chart)", x = "Year", y = "Poverty Rate (%)")
  })
  
  # Line Chart
  output$line_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = value, group = 1)) +
      geom_line(color = "darkblue", size = 1) +
      geom_point(color = "red", size = 2) +
      theme_minimal() +
      labs(title = "Poverty Rate (Line Chart)", x = "Year", y = "Poverty Rate (%)")
  })
  
  # Scatter Plot
  output$scatter_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = value)) +
      geom_point(color = "purple", size = 3) +
      theme_minimal() +
      labs(title = "Poverty Rate (Scatter Plot)", x = "Year", y = "Poverty Rate (%)")
  })
}

shinyApp(ui = ui, server = server)