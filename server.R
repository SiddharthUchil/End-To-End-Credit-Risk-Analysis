library(shiny)
library(caret)
library(randomForest)

shinyServer(function(input, output) {
  
  credit <- read.csv('data/german_credit.csv', header = TRUE)
  credit$Duration.of.Credit..month. <- cut(credit$Duration.of.Credit..month., c(0,12,18,24,Inf), labels = c(1:4))
  credit$Credit.Amount <- cut(credit$Credit.Amount, c(0,1000,5000,10000,Inf), labels = c(1:4))
  credit$Age..years. <- cut(credit$Age..years., c(18,25,40,60,Inf), labels = c(1:4))
  for(i in 1:21) credit[, i] <- as.factor(credit[, i])
  set.seed(2828)
  inTraining <- createDataPartition(credit$Creditability, p=0.7, list=FALSE)
  train <- credit[inTraining,]
  set.seed(2828)
  rfModel <- randomForest(Creditability ~ ., data=train)
  inputDF <- credit[-(2:1000),]
  
  # Return accept/reject decision 
  values <- reactiveValues()
  observe({
    input$action_Calc
    inputDF[1,-1] <- isolate(c(input$account_balance, input$duration_of_credit,
                               input$payment_status_previous_credit, input$purpose,
                               input$credit_amount, input$value_savings,
                               input$length_employment, input$instalment_percent,
                               input$sex_marital_status, input$guarantors,
                               input$duration_current_address, input$most_valuable_asset,
                               input$age, input$concurrent_credits,
                               input$type_apartment, input$num_credits_this_bank,
                               input$occupation, input$num_dependents,
                               input$telephone, input$foreign_worker))
    decision <- predict(rfModel, inputDF, type = 'prob')
    if(decision[2] > decision[1]){
      decision = 'ACCEPT'
    } else {
      decision = 'REJECT'
    }
    values$decision <- decision
  })
  
  # Display decision
  
  output$decision <- renderText({
    if(input$action_Calc == 0) ""
    else
      out <- paste(values$decision)
    
  })
})