library(shiny)
library(shinyjs)

shinyUI(
  fluidPage(align="center",
            useShinyjs(),
            headerPanel("Text Prediction"),
            mainPanel(class="col-sm-offset-2",
                      h3("Please type or paste text into the box below"),
                      h5("This application will predict the next word in your input. Note the top prediction "),
                      tags$textarea(id="text", class="form-control input-lg", label = "Input Text", value="enter text here", rows="4"),
                      span('Please wait several seconds for the algorithm to run.', class="help-block text-left"),
                      tags$hr(),
                      actionButton("result2", textOutput('result2', inline = TRUE), class="btn btn-lg"),
                      actionButton("result1", textOutput('result1', inline = TRUE), class="btn btn-lg btn-primary"),
                      actionButton("result3", textOutput('result3', inline = TRUE), class="btn btn-lg")
            )
  )
)