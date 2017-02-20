#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(googleVis)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    observeEvent(input$CheckClk, 
  { 
    bmi <- reactive( {wt <- isolate(input$Weight)
    ht <- as.numeric(isolate(input$Height_ft)) * 12 + as.numeric(isolate(input$Height_In))
    bmi <- (wt / ht^2)*703
    })
    
    suggMinWt <- reactive( {
      ht <- as.numeric(isolate(input$Height_ft)) * 12 + as.numeric(isolate(input$Height_In))
      suggMinWt <- ceiling((18.5/703)*(ht^2))
    })
  
    suggMaxWt <- reactive( {
      ht <- as.numeric(isolate(input$Height_ft)) * 12 + as.numeric(isolate(input$Height_In))
      suggMaxWt <- ceiling((24.9/703)*(ht^2))
    })
    
  
      output$text <- renderText(bmi())

      
     output$plot <- renderGvis({
        Gauge <-  gvisGauge(data.frame(Label="BMI",value=bmi()), 
                            options=list(min=10, max=40,greenFrom=18.5,
                                         greenTo=24.9, yellowFrom=25, yellowTo=29.9,
                                         redFrom=30, redTo=40, width=400, height=300))
      })
     
     output$category <- renderText( {
       if (bmi() < 18.5) {
         category <- "UnderWeight"
       }
       if(bmi() >= 18.5 && bmi() <= 24.9) {
         category <- "Normal"
       }
       if(bmi() >= 25 && bmi() <= 29.9) {
         category <- "Overweight"
       }
       if(bmi() >= 30) {
         category <- "Obese"
       }
       category
     })
     
     output$SuggMinWt <- renderText({
       paste("Recommended Minimum Weight(in lbs) :",suggMinWt())
       }
       )
     
     output$SuggMaxWt <- renderText({
       paste("Recommended Maximum Weight(in lbs) : ",suggMaxWt())
       })
     
     output$HeightTx <- renderText({
       paste("For Height ", isolate(input$Height_ft), " feet ", isolate(input$Height_In) , " inches ")
     })
  })
  })

