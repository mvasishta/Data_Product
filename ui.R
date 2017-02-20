#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("BMI Calculator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    
    sidebarPanel(
      fluidRow(sliderInput("Weight",
                           "Weight(in lbs)",
                           min = 5,
                           max = 400,
                           value = 130)),
      fluidRow(h4("Height")),
      fluidRow(
        column(3, textInput("Height_ft",'',5,'100%')),
        column(1,h5("ft"),style="padding:20px;"),
        column(3,textInput("Height_In",'',4,'100%')),
        column(1,h5("in"),style="padding:20px;")
        
      ),
      actionButton(inputId = "CheckClk",label="Check It!")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type="tabs",
                  tabPanel("Documentation",
                           h5("1.  Welcome to BMI Calculator Application !. This is a simple application to calculate the Body Mass Index(BMI) of the person"),
                           tags$br(),
                           h5("2.  According to National Institute of Health(", tags$a(href="https://www.nhlbi.nih.gov/health/educational/lose_wt/risk.htm","NIH link"),"), BMI is an estimate of body fat and a good gauge of your risk for diseases that can occur with more body fat"),
                           tags$br(),
                           h5("3.  The formula to calculate BMI is abtained from website(",tags$a(href="http://www.calculator.net/bmi-calculator.html","Click here"),")."),
                           tags$br(),
                           h5("4.  The application uses GoogleVis package to provide a gauge visualization of the BMI indicator"),
                           tags$br(),
                           h5("5.  BMI calculator also indicates whether the person is \"Underweight\",\"Normal\",\"Overweight\",\"Obese\"."),
                           tags$br(),
                           h5("6. Go ahead & try it yourself.  Click on \"Result\" tab and play around with \"Weight\" slider, key in \"Height\" inputs and press \"Check It!\" !" )
                  ),
                  tabPanel("Result",
                           fluidRow(
                           column(4,htmlOutput("plot")),
                           column(2,h2(textOutput("category")),style="padding:100px;")
                           ),
                          tags$br(),
                          fluidRow(h4(textOutput("HeightTx"))),
                          tags$br(),
                          fluidRow(
                            textOutput("SuggMinWt"),
                            textOutput("SuggMaxWt")
                          )
                  )
    )
    
    
  )
)
))


