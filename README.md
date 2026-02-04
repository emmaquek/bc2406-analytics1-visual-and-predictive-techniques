# Analytics I: Visual and Predictive Techniques

This repository contains coursework and project submissions for **Analytics I: Visual and Predictive Techniques**.  
The module focuses on identifying suitable problems for predictive analytics, applying statistical and machine learning models, evaluating performance, and translating results into actionable insights.  
Across team projects, visual analytics and predictive modelling were applied to real-world legal and public health contexts.

---

## Tools & Technologies Used

- **RStudio** – primary development environment  
- **R (Programming Language)**  
- **Core Packages:**  
  - `ggplot2` – data visualisation and exploratory analysis  
  - `dplyr` – data manipulation and preparation  
  - `rpart` – Classification and Regression Tree (CART) modelling  
  - `rpart.plot` – visualisation of decision trees  
  - `shiny` – development of interactive analytical prototypes

---

## Projects Overview

### 1. Gender Discrimination Lawsuit Analysis (Team Project – Visual Analytics & Regression)

**Project Context:**  
This project analyses a real-world gender discrimination lawsuit involving academic faculty promotions and salaries. The objective was to assess whether observed salary and rank differences could be explained by measurable factors such as experience, department, and productivity, or whether gender effects persisted after controlling for these variables.

**My Contribution:**  
Exploratory visual analysis and regression-based modelling to examine salary distributions and contributing factors.

**Key Methods & Applications:**
- Developed **density plots** to visualise salary distributions by gender and highlight differences in spread and central tendency
- Applied **linear regression models** to evaluate the impact of gender while controlling for experience, certification, clinical emphasis, and publication rate
- Interpreted coefficients, p-values, and diagnostics to assess the strength and reliability of observed relationships
- Highlighted model limitations (e.g. non-linearity, outliers) and their implications for legal and business interpretation

---

### 2. Diabetes Risk Prediction & Preventive Health Application (Team Project – Predictive Modelling)

**Project Context:**  
This project aligns with Singapore’s **Healthier SG** initiative and focuses on improving early awareness of diabetes risk. The objective was to develop a predictive model that estimates an individual’s likelihood of developing diabetes based on health and lifestyle indicators, and to communicate results in an accessible manner.

**My Contribution:**  
Tree-based modelling and independently initiated the development of an interactive prototype application to operationalise the predictive model.

**Key Methods & Applications:**
- Implemented **Classification and Regression Tree (CART)** models using `rpart` and `rpart.plot` to produce interpretable predictions
- Independently researched and developed an **interactive prototype application using the `shiny` package in R**, extending beyond the original project requirements
- Applied **train–test splits** to evaluate model performance and avoid overfitting
- Analysed model outputs to balance predictive accuracy with interpretability
- Used the prototype to package the predictive model into a user-facing tool, demonstrating how analytics can be deployed as a practical decision-support solution

---

## Technical Skills Demonstrated

- Data visualisation and exploratory analysis  
- Linear regression and model diagnostics  
- Tree-based predictive modelling (CART)  
- Model evaluation using train–test splits  
- Translating analytical models into interactive applications (R Shiny)  
- Communicating insights to non-technical audiences
