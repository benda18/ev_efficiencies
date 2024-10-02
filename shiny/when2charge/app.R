#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(renv)
library(scales)
library(ggplot2)
library(lubridate)

#renv::snapshot()
#renv::status()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("EV Charging Helper - Durham, NC"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           #plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  # functions----
  getprice_evgo <- function(date_time){
    require(dplyr)
    temp.hr <- date_time %>% hour()
    temp.min <- date_time %>% minute()
    temp.min <- temp.min / 60
    
    temp.sec <- date_time %>% second()
    temp.sec <- temp.sec / 60 / 60
    
    temp.time <- temp.hr + 
      temp.min + 
      temp.sec
    
    if(nchar(temp.min*60)==1){
      temp.min <- paste("0", temp.min*60, sep = "")
    }else{
      temp.min <- as.character(temp.min*60)
    }
    
    price.out <- NA
    
    if(temp.time < 8){
      price.out <- 0.26
    }
    
    if(between(temp.time, 8, 10) | 
       between(temp.time, 19, 24)){
      price.out <- 0.30
    }
    
    if(between(temp.time, 10, 19)){
      price.out <- 0.34
    }
    # time
    x <- temp.time
    x.hour   <- x %/% 1
    x.ampm   <- ifelse(x > 11, "PM", "AM")
    x.hour   <- ifelse(x > 12, x - 12, x) %/% 1
    #x.minute <- ((x %% 1)*60) %/% 1
    #x.time <- paste(x.hour,":",x.minute," ", x.ampm, sep = "")
    x.time <- paste(x.hour, ":", 
                    temp.min, 
                    x.ampm,
                    sep = "")
    return(list(time = x.time, 
                price.per.Kw = price.out))
  }
  # data----
  
    
  
  # server stuff----
  # output$distPlot <- renderPlot({
  #       # generate bins based on input$bins from ui.R
  #       x    <- faithful[, 2]
  #       bins <- seq(min(x), max(x), length.out = input$bins + 1)
  # 
  #       # draw the histogram with the specified number of bins
  #       hist(x, breaks = bins, col = 'darkgray', border = 'white',
  #            xlab = 'Waiting time to next eruption (in mins)',
  #            main = 'Histogram of waiting times')
  #   })
}

# Run the application 
shinyApp(ui = ui, server = server)
