library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Credit Risk Evaluator"),
  sidebarLayout(
    sidebarPanel(
      helpText("This app evaluates whether a loan applicant should be considered a good or bad credit risk and delivers an accept or reject recommendation"),            
      selectInput("account_balance",
                  label = h6("Account Balance"),
                  choices = list("< 0 DM" = 1,
                                 "0 - 200 DM" = 2,
                                 "> 200 DM / Salary assignments for at least 1 year" =3,
                                 "No checking account" = 4),
                  selected = 1 
      ),
      selectInput("duration_of_credit",
                  label = h6("Duration of Credit (Months)"),
                  choices = list("0 - 12 months" = 1,
                                 "13 - 18 months" = 2,
                                 "19 - 24 months" =3,
                                 "> 24 months" = 4),
                  selected = 1 
      ),
      selectInput("payment_status_previous_credit",
                  label = h6("Payment Status of Previous Credit"),
                  choices = list("No credits taken / All credits paid back duly" = 0,
                                 "All credits at this bank paid back duly" = 1,
                                 "Existing credits paid back duly till now" =2,
                                 "Delay in paying off in the past" = 3,
                                 "Critical account / Other credits existing (not at this bank)" = 4),
                  selected = 1 
      ),
      selectInput("purpose",
                  label = h6("Purpose"),
                  choices = list("Car (new)" = 0,
                                 "Car (used)" = 1,
                                 "Furniture / Equipment" = 2,
                                 "Radio / Television" = 3,
                                 "Domestic Appliances" = 4,
                                 "Repairs" = 5,
                                 "Education" = 6,
                                 "Re-training" = 7,
                                 "Business" =8,
                                 "Other" = 9),
                  selected = 1 
      ),
      selectInput("credit_amount",
                  label = h6("Credit Amount"),
                  choices = list("0 - 1,000 DM" = 1,
                                 "1,001 - 5,000 DM" = 2,
                                 "5,001 - 10,000 DM" =3,
                                 "> 10,000 DM" = 4),
                  selected = 1 
      ),
      selectInput("value_savings",
                  label = h6("Value of Savings/Stocks"),
                  choices = list("< 100 DM" = 1,
                                 "100 - 500 DM" = 2,
                                 "500 - 1000 DM" = 3,
                                 "> 1000 DM" =4,
                                 "Unknown / No Savings Account" = 5),
                  selected = 1 
      ),
      selectInput("length_employment",
                  label = h6("Length of Current Employment"),
                  choices = list("Unemployed" = 1,
                                 "< 1 Year" = 2,
                                 "1 - 4 Years" = 3,
                                 "4 - 7 Years" =4,
                                 "> 7 Years" = 5),
                  selected = 1 
      ),
      selectInput("instalment_percent",
                  label = h6("Instalment (%) of Disposable Income"),
                  choices = list("1%" = 1,
                                 "2%" = 2,
                                 "3%" =3,
                                 "4% and above" = 4),
                  selected = 1 
      ),
      selectInput("sex_marital_status",
                  label = h6("Sex and Marital Status"),
                  choices = list("Male : Divorced / Separated" = 1,
                                 "Female : Divorced / Separated / Married " = 2,
                                 "Male : Single" = 3,
                                 "Male : Married / Widowed" = 4,
                                 "Female : Single" = 5),
                  selected = 1
      ),
      selectInput("guarantors",
                  label = h6("Guarantors"),
                  choices = list("None" = 1,
                                 "Co-applicant" = 2,
                                 "Guarantor" = 3),
                  selected = 1 
      ),
      selectInput("duration_current_address",
                  label = h6("Time in Current Address"),
                  choices = list("< 1 Year" = 1,
                                 "1 - 2 Years" = 2,
                                 "2 - 3 Years" =3,
                                 "> 3 Years" = 4),
                  selected = 1 
      ),
      selectInput("most_valuable_asset",
                  label = h6("Most Valuable Available Asset"),
                  choices = list("Real Estate" = 1,
                                 "Building Society Savings Agreement / Life Insurance" = 2,
                                 "Car or Other" =3,
                                 "Unknown / No Property" = 4),
                  selected = 1 
      ),
      selectInput("age",
                  label = h6("Age"),
                  choices = list("18 - 25" = 1,
                                 "26 - 40" = 2,
                                 "41 - 60" =3,
                                 "Over 60" = 4),
                  selected = 1 
      ),
      selectInput("concurrent_credits",
                  label = h6("Concurrent Credits"),
                  choices = list("Bank" = 1,
                                 "Stores" =2,
                                 "None" = 3),
                  selected = 1 
      ),
      selectInput("type_apartment",
                  label = h6("Type of Apartment"),
                  choices = list("Rent" = 1,
                                 "Own" = 3,
                                 "For Free" = 4),
                  selected = 1 
      ),
      selectInput("num_credits_this_bank",
                  label = h6("Number of Credits at This Bank"),
                  choices = list("1" = 1,
                                 "2" = 2,
                                 "3" =3,
                                 "4 or more" = 4),
                  selected = 1 
      ),
      selectInput("occupation",
                  label = h6("Occupation"),
                  choices = list("Unemployed / Unskilled - Non-resident " = 1,
                                 "Unskilled - Resident " = 2,
                                 "Skilled Employee / Official " =3,
                                 "Management / Self-employed / 
Highly Qualified Employee / Officer " = 4),
                  selected = 1 
      ),
      selectInput("num_dependents",
                  label = h6("Number of Dependents"),
                  choices = list("0 - 1" = 1,
                                 "2 or more" = 2),
                  selected = 1 
      ),
      selectInput("telephone",
                  label = h6("Telephone"),
                  choices = list("None" = 1,
                                 "Yes, Registered Under the Customer's Name" = 4),
                  selected = 1 
      ),
      selectInput("foreign_worker",
                  label = h6("Foreign Worker"),
                  choices = list("Yes" = 1,
                                 "No" = 2),
                  selected = 1 
      ), 
      br(),
      actionButton("action_Calc", label = "Evaluate")        
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Output",
                 p(h4("Recommendation:")),
                 textOutput("decision"),
                 tags$head(tags$style("#decision{color: white; font-size: 60px;}")
                 )
        ),
        tabPanel("Documentation",
                 p(h4("Credit Risk Evaluator:")),
                 br(),
                 helpText("This application evaluates whether or not a credit applicant has good or bad credit risk and delivers an accept or reject recommendation. The model was developed using a random forests model which was run on a data set of 1000 German credit applications."),
                 HTML("")                
        )
      )
    )
  )
))