
# Setup
setwd("")

# Install Packages
# install.packages("data.table")
# install.packages("ggplot2")
# install.packages("MASS")

# Read Libraries
library(data.table)
library(ggplot2)
library(MASS)

# Read Data
lawsuit.dt <- fread("lawsuit.csv")


# Data Check
dim(lawsuit) # row: 261, col: 10
colnames(lawsuit)
table(lawsuit$Gender) # Female (0): 106, Male (1): 155
summary(lawsuit)
str(lawsuit)
describe(lawsuit)


# Data Preparation

# Categorical: Dept, Gender, Clin, Cert
lawsuit.dt$ID <- as.factor(lawsuit$ID)
lawsuit.dt$Dept <- as.factor(lawsuit$Dept)
lawsuit.dt$Clin <- as.factor(lawsuit$Clin)
lawsuit.dt$Cert <- as.factor(lawsuit$Cert)
lawsuit.dt$Gender_Group <- as.factor(lawsuit.dt$Gender)

# Categorical Order: Rank
lawsuit.dt$Rank_Group <- factor(lawsuit.dt$Rank,
                             levels = c(1, 2, 3),
                             labels = c("Assistant", "Associate", "Full"))


class(lawsuit.dt$ID)
class(lawsuit.dt$Dept)
class(lawsuit.dt$Clin)
class(lawsuit.dt$Cert)
class(lawsuit.dt$Gender_Group)
class(lawsuit.dt$Rank_Group)


# Continuous Columns: Prate, Exper, Sal94, Sal95
class(lawsuit.dt$Prate)
class(lawsuit.dt$Exper)
class(lawsuit.dt$Sal94)
class(lawsuit.dt$Sal95)

#=========================================================================================================
#Slide 5 code - Does Gender Affect Rank Directly?
lawsuit.dt[, .(mean_Sal94 = mean(Sal94, na.rm = TRUE),
               median_Sal94 = median(Sal94, na.rm = TRUE),
               mean_Sal95 = mean(Sal95, na.rm = TRUE),
               median_Sal95 = median(Sal95, na.rm = TRUE)),
           by = Gender_Group]

## DENSITY PLOT - SALARY
ggplot(lawsuit.dt, aes(x = Sal95, fill = Gender_Group)) +
  geom_density(alpha = 0.5) +
  labs(title = "Salary Density by Gender (1995)", x = "Salary", y = "Density") +
  scale_fill_manual(values = c("Male" = "lightblue", "Female" = "pink"))+
  scale_x_continuous(labels = scales::dollar)+
  theme_minimal()

ggplot(lawsuit.dt, aes(x = Sal94, fill = Gender_Group)) +
  geom_density(alpha = 0.5) +
  labs(title = "Salary Density by Gender (1994)", x = "Salary", y = "Density") +
  scale_fill_manual(values = c("Male" = "lightblue", "Female" = "pink"))+
  scale_x_continuous(labels = scales::dollar)+
  theme_minimal()

#=========================================================================================================
#Slide 6 code - Higher Likelihood of Male in Senior Ranks
m.sal.94 <- lm(Sal94 ~ Gender + Cert + Clin + Exper + Prate, data = lawsuit.dt)
summary(m.sal.94)
par(mfrow = c(2,2))
plot(m.sal.94)
par(mfrow = c(1,1))

m.sal.95 <- lm(Sal95 ~ Gender + Cert + Clin + Exper + Prate, data = lawsuit.dt)
summary(m.sal.95)
par(mfrow = c(2,2))
plot(m.sal.95)
par(mfrow = c(1,1))

