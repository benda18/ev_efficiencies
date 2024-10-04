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
          plotOutput(outputId = "the.plot")
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
    
    # handle leading zeroes
    if(nchar(temp.min*60)==1){
      temp.min <- paste("0", temp.min*60, sep = "")
    }else{
      temp.min <- as.character(temp.min*60)
    }
    
    # pricing info
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
    # return(list(time = x.time, 
    #             price.per.Kw = price.out))
    return(price.out)
  }
  
  getprice_tsla <- function(date_time){
    require(dplyr)
    temp.hr <- date_time %>% hour()
    temp.min <- date_time %>% minute()
    temp.min <- temp.min / 60
    
    temp.sec <- date_time %>% second()
    temp.sec <- temp.sec / 60 / 60
    
    temp.time <- temp.hr + 
      temp.min + 
      temp.sec
    
    # handle leading zeroes
    if(nchar(temp.min*60)==1){
      temp.min <- paste("0", temp.min*60, sep = "")
    }else{
      temp.min <- as.character(temp.min*60)
    }
    
    # pricing info
    price.out <- NA
    
    if(temp.time < 4 | temp.time >= 23){
      price.out <- 0.20
    }
    
    
    if(between(temp.time, 4, 13) ){
      price.out <- 0.37
    }
    
    if(between(temp.time, 13, 23)){
      price.out <- 0.43
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
    # return(list(time = x.time, 
    #             price.per.Kw = price.out))
    return(price.out)
  }
  
  # data----
  
  the.data <- expand.grid(hour = c(0:23), 
                          kWh = seq(5,65,by=10)/1, 
                          provider = c("Tesla",
                                       "EVgo", "EA")) %>%
    mutate(., 
           prc = NA, 
           t_usd = NA) %>% as_tibble()
    
  
  the.data[the.data$provider == "EVgo",]$prc <- ymd_h("2024-10-01 0AM", 
                                                  tz = "America/New_York") %m+% 
    hours(the.data$hour[the.data$provider == "EVgo"]) %>%
    lapply(.,
           FUN = getprice_evgo) %>%
    unlist()
  
  the.data[the.data$provider == "Tesla",]$prc <- ymd_h("2024-10-01 0AM", 
                                                      tz = "America/New_York") %m+% 
    hours(the.data$hour[the.data$provider == "Tesla"]) %>%
    lapply(.,
           FUN = getprice_tsla) %>%
    unlist()
  
  the.data$prc[the.data$provider == "EA"] <- 0.36
  
  the.data <- mutate(the.data, 
         t_usd = prc * kWh)
  
  slice_min(group_by(the.data, hour), 
            order_by = prc, 
            n = 1)
  
  # server stuff----
  
  output$the.plot <- renderPlot({
    ggplot() + 
      geom_col(position = "dodge", 
               data = the.data, 
                 aes(x = hour, y = kWh, 
                     size = t_usd, fill = provider))+
      theme_dark() +
      labs(title = "foo title") #+
      #facet_grid(provider~.)
  })
  
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
