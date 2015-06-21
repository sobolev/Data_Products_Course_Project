# By default, the file size limit is 5MB. It can be changed by
# setting this option. Here we'll raise limit to 9MB.
library(shiny)
library(car)    # recode function

life.table<-data.frame(read.csv("SS_2010_Life.csv", header = TRUE, sep = ","))


shinyServer(function(input, output) {
    
    values <- reactiveValues()
    # Calculate the interest and amount    
    observe({
        input$action_Calc
        values$exp_life <- isolate({
            life.table[input$slider_currage+1,recode(isolate(input$select_gender),"1=4;2=7")]+input$slider_currage  
        })
        currlives<-life.table[input$slider_currage+1,recode(isolate(input$select_gender),"1=3;2=6")]
        years<-ifelse(input$slider_years<input$slider_currage,input$slider_currage,input$slider_years)
        desiredlives<-life.table[years+1,recode(isolate(input$select_gender),"1=3;2=6")]
        values$prob <- round(1-(currlives - desiredlives)/currlives,4)
        values$ages<-life.table[(input$slider_currage+1):(years+1),1]
        values$lives<-life.table[(input$slider_currage+1):(years+1),recode(isolate(input$select_gender),"1=3;2=6")]/currlives
        })
    
    # Display values entered
    output$text_currage <- renderText({
        input$action_Calc
        paste("Current Age:", isolate(input$slider_currage), " years")
    })
    
    output$text_years <- renderText({
        input$action_Calc
        paste("Desired Age: ", isolate(input$slider_years), 
              " years")
    })
    
    output$text_gender <- renderText({
        input$action_Calc
        paste("Gender: ",
              recode(isolate(input$select_gender),
                     "1 = 'Male'; 2 = 'Female'")
        )
    })
    
    # Display calculated values
    
    output$text_exp_life <- renderText({
        if(input$action_Calc == 0) ""
        else
            paste("Expected age you will live to: ", values$exp_life, " years")
    })
    
    output$text_prob <- renderText({
        if(input$action_Calc == 0) ""
        else 
            paste("Probability you will live to be ",isolate(input$slider_years)," years old: ", values$prob)
    })
    
    output$plot_lives <- renderPlot({
        if(input$action_Calc == 0) ""
        else 
           plot(values$ages,values$lives,
                type="s",
                col="red",
                main="Probability of Living to Target Age by Year",
                xlab="Age in Years",
                ylab="Probability of Living to Age")
    })
    
})