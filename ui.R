# Coursera Developing Data Products Course Project
# Longely dataset regression model

library(shiny)
library(datasets)
library(dplyr)
library(rsconnect)
library(markdown)

# Define UI for application that draws a histogram
shinyUI(
    navbarPage("Longley Regression Model", 
               tabPanel("Select Predictor(s)", 
                        sidebarPanel(
                            width = 4, 
                            
                            checkboxGroupInput("checkGroup", 
                                               label = h3("Predictor(s)"), 
                                               choices = names(select(longley, -Employed)), 
                                               selected = "GNP"), 
                            
                        ), 
                        
                        mainPanel(
                            h4(textOutput("caption")), 
                            p("Regression Coefficients"), 
                            verbatimTextOutput("fit"), 
                            p("Adjusted R Squared"), 
                            verbatimTextOutput("adj_r_squared"), 
                            plotOutput("plot_pred")
                        ), 
                        
                        ), 
               tabPanel("About", 
                        mainPanel(
                            includeMarkdown("info.Rmd")
                                )
                        )
               )
    )
    