# Coursera Developing Data Products Course Project
# Longely dataset regression model

library(shiny)
library(datasets)
library(rsconnect)

# Define server logic required for regression model
shinyServer(function(input, output) {
    
    # Get all the checked values separated by + (example GNP + Population), if 
    # nothing is checked make it 1
    checkedVal <- reactive({
        perm.vector <- as.vector(input$checkGroup)
        predForm<-ifelse(length(perm.vector)>0,
                         predictors<-paste(perm.vector,collapse="+"),
                         "1")
        lmForm<-paste("Employed ~ ",predForm,sep="") 
        
    }) 
    
    fitModel <- reactive({
        fitFormula <- as.formula(checkedVal())
        lm(fitFormula, data = longley)
    })
    
    output$caption <- renderText({
        checkedVal()
    })
    
    #Print the coeffecients of the regression model
    output$fit <- renderPrint({
        summary(fitModel())$coef
    })
    
    #Print adjusted R square value
    output$adj_r_squared <- renderPrint({
        summary(fitModel())$adj.r.squared
        
    })
    
    #Plot observed vs. predicted values
    output$plot_pred<-renderPlot({
        plot(predict(fitModel(), longley), longley$Employed, 
             xlab = "Predicted Values", 
             ylab = "Observed Values",
             title("Observed vs. Predicted Plot"))
        abline(a = 0, b =1, col = "red")
        
    })
})
