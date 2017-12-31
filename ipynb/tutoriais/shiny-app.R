library(shiny)

# isso pode ser chamado a partir de um source('shiny-app.R')

meu_app <- shinyApp(
ui = fluidPage(

  # App title ----
  titlePanel("Hello Shiny!"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)

    ),

    # Main panel for displaying outputs ----
    mainPanel(

      # Output: Histogram ----
      plotOutput(outputId = "distPlot")

    )
  )
)
,
server = function(input, output) {

  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({

    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

    })

}
)

runApp(meu_app, host = "http://localhost:8888")

runApp(appDir = getwd(),
         port = getOption("shiny.port"),
launch.browser = getOption("shiny.launch.browser", interactive()),
host = getOption("shiny.host", "127.0.0.1"),
workerId = "",
 quiet = FALSE,
 display.mode = c("auto", "normal", "showcase"))

options(shiny.port) # to check port

# Código para finalizar o aplicativo.
shinyServer(function(input, output, session) {
    ...
    ...
    session$onSessionEnded(function() { stopApp() })
    }
)




## Criar diretório com short path.
dir.create("~/Downloads/jena_climate", recursive = TRUE)

download.file(
  "https://s3.amazonaws.com/keras-datasets/jena_climate_2009_2016.csv.zip",
  "~/Downloads/jena_climate/jena_climate_2009_2016.csv.zip"
)
unzip(
  "~/Downloads/jena_climate/jena_climate_2009_2016.csv.zip",
  exdir = "~/Downloads/jena_climate"
)
Let’s look at the data.

library(tibble)
library(readr)

data_dir <- "~/Downloads/jena_climate"
fname <- file.path(data_dir, "jena_climate_2009_2016.csv")
data <- read_csv(fname)