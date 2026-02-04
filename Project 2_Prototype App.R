


library(shiny)

cart_model <- readRDS("cart_model.rds")
log_model <- readRDS("log_model.rds")


ui <- fluidPage(
  titlePanel("Diabetes Risk Prediction Prototype App"),
  sidebarLayout(
    sidebarPanel(
      selectInput("HighBP", "Does the patient have High Blood Pressure? (1=Yes, 0=No)", choices = c(0,1)),
      selectInput("HighChol", "Does the patient have High Cholesterol? (1=Yes, 0=No)", choices = c(0,1)),
      selectInput("Age", "What is the patient's age group? (based on 13-level age category)", choices = 1:13),
      numericInput("BMI", "What is the patient's BMI?", value = 25, min = 15, max = 50),
      selectInput("GenHlth", "Would the patient say that in general their health is: scale 1-5 1 = excellent 2 = very good 3 = good 4 = fair 5 = poor?", choices = c(1,2,3,4,5)),      
      selectInput("Income", "What is the patient's Income Category? (based on 8-level income scale)", choices = 1:8),
      actionButton("predictBtn", "Predict Risk")
    ),
    mainPanel(h3("Risk Prediction"),textOutput("prediction")))
  )


server <- function(input, output) {
  user_data <- reactive({
    data.frame(
      HighBP = factor(input$HighBP, levels=c(0,1)),
      GenHlth = factor(input$GenHlth, levels=as.character(1:5)),
      Age = factor(input$Age, levels=as.character(1:13)),
      BMI = as.numeric(input$BMI),
      HighChol = factor(input$HighChol, levels=c(0,1)),
      Income = factor(input$Income, levels=as.character(1:8)),
      CholCheck=factor("0", levels=c(0,1)), Smoker=factor("0", levels=c(0,1)), Stroke=factor("0", levels=c(0,1)), 
      HeartDiseaseorAttack=factor("0", levels=c(0,1)), PhysActivity=factor("0", levels=c(0,1)), Fruits=factor("0", levels=c(0,1)), 
      Veggies=factor("0", levels=c(0,1)), HvyAlcoholConsump=factor("0", levels=c(0,1)), AnyHealthcare=factor("0", levels=c(0,1)), 
      NoDocbcCost=factor("0", levels=c(0,1)), MentHlth=0, PhysHlth=0, DiffWalk=factor("0", levels=c(0,1)), 
      Sex=factor("F", levels=c("M","F")), Education=factor("1", levels=as.character(1:6))
      )
    })
  result <- eventReactive(input$predictBtn, {
    p_cart <- predict(cart_model, newdata = user_data(), type = "prob")[,2]
    p_log <- predict(log_model, newdata = user_data(), type = "response")
    p_combined <- 0.5 * p_cart + 0.5 * p_log
    ifelse(p_combined > 0.5,
           paste0("Probability: ", round(p_combined, 3), " -> At Risk. Please arrange follow-ups."),
           paste0("Probability: ", round(p_combined, 3), " -> Not at Risk. "))
    })
    output$prediction <- renderText({ result() })
}

shinyApp(ui = ui, server = server)



