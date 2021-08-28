library(plotly)
library(stringr)

#Load weather data
df = readRDS("WeatherEvents_Jan2016-Dec2020.rds")

#Add occurrence for later on
df$oc <- rep(1,nrow(df))

# Define server logic ----
server <- function(input, output) {
  
  # USA map displaying selected event frequency ----
  output$mapFreq <- renderPlotly({
    
    #Select event based on input: event type
    dfEvent <- df[which(df$Type == input$var),]
    #Select event based on input: severity/ies
    dfEvent <- dfEvent[which(dfEvent$Severity %in% c(input$checkGroup)),]
    #Select event based on input: year(s)
    dfEvent <- dfEvent[which(dfEvent$Year %in% c(input$slider)),]
    
    #If data to show
    if(nrow(dfEvent) > 0){
      #Compute frequency = sum of events
      dfFreq <- aggregate(dfEvent$oc,by=list("State"=dfEvent$State),sum)
      colnames(dfFreq) <- c("State","Freq")
      Frequency <- dfFreq$Freq
      
      #Element for map
      plot_geo() %>%
        add_trace(
          z = ~Frequency, text = dfFreq$State,
          locations = dfFreq$State, 
          locationmode = 'USA-states'
        ) %>%
        layout(geo = list(
          scope = 'usa',
          projection = list(type = 'albers usa'),
          lakecolor = toRGB('white')
        ))
    }else{
      plotly_empty() %>%
      layout(title = "No data to show with selected parameters") 
    }

  })
  
}