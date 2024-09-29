# Predicting Cases in Wave Two of the Coronavirus

### Project Overview

In this project, coronavirus cases in wave one of the virus will be investigated as well as deprivation data that may be correlated to the rate of cases. Deprivation data include education, health, crime, income, housing, living and employment and these variables will be further analysed to determine if they are strongly correlated to the rate of covid cases. Once the relationship between deprivation data and covid cases has been established a predictive model will be produced to predict the rate of coronavirus cases for wave two of the virus.

### Data Sources

DeprivationData.RData is the primary dataset used for this project which provides deprivation data in areas of the United Kingdom, as well as data on the number of coronavirus cases in these areas. 

### Tools

- R Studio - Data Modelling and Visualisation 

### Regression Modelling

First a regression model was fit to determine the strength of the relationship between deprivation variables and the rate of covid cases. From carrying out various tests, it was concluded that deprivation data and rate of covid cases are correlated with each other and this relation is plotted in a line graph. 

### Predictive Modelling 

As there are different variables within deprivation data we must choose the variables that are the most strongly correlated to covid cases to create a predictive model that is as accurate as possible. Leaps and Bounds variable selection will be carried out to help search for the 'best models'. Mallows cp and press will be calculated for each model to determine the best model and transformations are carried out on the predictor variables to ensure any important variables are not omitted. The final model is:

y = AverageRate * Education + Health + Crime

Once the final model has been chosen this is plotted in a line graph to visualise the rate of covid cases throughout wave two of the virus. 

### Results/findings 

When comparing the predictive model to the actual model it was found that the actual rate of cases was lower than the predicted cases and this is likely due to the increase of induviduals getting vaccinated. 

### Limitations 

The model only applies to a speific area within the UK and therefore may not be as accurate if using to predict cases worldwide. 

