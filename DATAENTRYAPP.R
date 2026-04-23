######################## BUILDING A DATASET IN R #####################

############# LOAD PACKAGES ############

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(shiny)
library(lubridate)
library(DT)

# Function for saving data to a CSV file
log_line <- function(newdata, filename = 'birds_data.csv'){
  (dt <- Sys.time() %>% round %>% as.character)
  (newline <- c(dt, newdata) %>% paste(collapse=',') %>% paste0('\n'))
  cat(newline, file=filename, append=TRUE)
  print('Data stored!')
}

################################################################################
################################################################################

ui <- fluidPage(
  titlePanel(h4("Bird Observations")),
  br(),
  fluidRow(
    # Example input: manual text entry
    column(4, textInput('text',
                        label='Bird Species',
                        value='',
                        width = '95%')),
    
    # Example input: selecting pre-canned options
    column(4, selectInput('select',
                          label='Identified by:',
                          choices = paste(c("Audio","Sight")),
                          width='95%')),
    
    # Example input: toggling between options
    column(4, textInput('location',
                           label='Rough Location:',
                           value='',
                           width='95%'))),
  br(),
  br(),
  fluidRow(column(2),
           # Save button!
           column(8, actionButton('save',
                                  h2('Save!'),
                                  width='100%')),
           column(2)),
)

################################################################################
################################################################################

server <- function(input, output) {
  
  # Save button ================================================================
  observeEvent(input$save, {
    newdata <- c(input$text, input$select, input$location)
    log_line(newdata)
    showNotification("Save successful!")
  })
  #=============================================================================
  
}

################################################################################
################################################################################

shinyApp(ui, server)
