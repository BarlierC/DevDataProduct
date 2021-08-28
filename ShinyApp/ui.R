library(plotly)

ui <- fluidPage(
  
  # App title ----
  titlePanel("Weather Events in USA"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      helpText("Create demographic maps of weather events that happened in the USA from 2016 to 2020."),

        selectInput("var", 
                  label = "Weather event",
                  choices = c("Snow", 
                              "Fog",
                              "Cold", 
                              "Storm",
                              "Rain",
                              "Precipitation",
                              "Hail"),
                  selected = "Snow"
        ),
      
        checkboxGroupInput("checkGroup", 
                         h3("Severity"), 
                         choices = list("Light" = "Light", 
                                        "Moderate" = "Moderate", 
                                        "Severe" = "Severe",
                                        "Heavy" = "Heavy",
                                        "Unknown" = "Unknown"),
                         selected = c("Light","Moderate","Severe","Heavy","Unknown")
        ),
        
        sliderInput("slider", h3("Year(s)"),
                      min = 2016, max = 2020, value = c(2016,2020), step = 1
        )
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Map displaying event frequency ----
      plotlyOutput("mapFreq")
      
    )
  )
)