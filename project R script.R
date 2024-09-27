#print first few rows of data
load("DeprivationData.RData")
head(DeprivationData1)
head(DeprivationData2)

# (i)
#calcualte sample correlation coefficient for first wave
cor(DeprivationData1$IMD, DeprivationData1$AverageRate)

#(ii)
#fit linear regression model
IMD.model <- lm(AverageRate ~ IMD, data = DeprivationData1)
summary(IMD.model)

#t test
qt(p=1-0.025, df = 45)

#(iii)
#check linearity
pairs(DeprivationData1[,1:2])
#print estimated coefficients
coef(IMD.model)
#store fitted values from the full model 
fit <- IMD.model$fitted.values
#plot residuals against fitted values
plot(IMD.model, which = 1)

#draw a qq plot 
plot(IMD.model, which = 2, xlab = "Theoretical Quantiles")

#(iv)
#plot data
plot(AverageRate ~ IMD, data = DeprivationData1,
     xlab = "Index of Multiple Deprivation (IMD)", ylab = "Average Rate")
abline(IMD.model, lwd = 1, col = "blue", lty = 1)
title(main = "Plot of Average Rate against IMD")                                                                                    

#confidence interval
lmoutput <- lm(AverageRate ~ IMD, data=DeprivationData1)

CIs <- predict(lmoutput, interval = 'confidence', level = 0.95)
CIs <- data.frame(CIs)   
CIs$IMD <- DeprivationData1$IMD
CIs[order(DeprivationData1$IMD),]
lines(CIs$IMD, CIs$lwr, lty = 2)
lines(CIs$IMD,CIs$upr, lty = 2)


#(v) leaps and bounds variable selction 
library(leaps)

best_subset <- leaps(x = DeprivationData1[,3:9], y = DeprivationData1[,2],
                     nbest = 5, method = "adjr2", names 
                     = colnames(DeprivationData1[,-c(1,2)]))

result.tab <- data.frame(adjr2=best_subset$adjr2, size=best_subset$size,
                         best_subset$which,row.names=NULL)

data.frame(result.tab)
plot(adjr2~size, data=result.tab,  
     xlab = "Number of variables", ylab = "Adjusted R-squared")

#fit full model
full.model <-lm(AverageRate~IMD + Income + Employment + Education +
                  Health + Housing + Crime + Living, 
                data = DeprivationData1)

#fit chosen models
model1 <- lm(AverageRate~ Education + Health + Crime, data = DeprivationData1)
model2 <-lm(AverageRate~ Employment +Education + Health + Crime, 
            data = DeprivationData1)
model3 <-lm(AverageRate~ Employment + Education + Health + Crime + 
              Living, data = DeprivationData1)

#calcualtes mallows cp for each model
ols_mallows_cp(model1, full.model)
ols_mallows_cp(model2, full.model)
ols_mallows_cp(model3, full.model)

 #calculate press for each model
press(model1)
press(model2)
press(model3)

#transformations
pairs(DeprivationData1[,c(2,4,5,6,8)])

plot(AverageRate ~ Education, data = DeprivationData1,
     xlab = "Education", ylab = "Average Rate")
title(main = "Average Rate against Education") 

plot(AverageRate ~ Health, data = DeprivationData1,
     xlab = "Health", ylab = "Average Rate")
title(main = "Average Rate against Health") 

plot(AverageRate ~ Crime, data = DeprivationData1,
     xlab = "Crime", ylab = "Average Rate")
title(main = "Average Rate against Crime") 

plot(AverageRate ~ Employment, data = DeprivationData1,
     xlab = "Employment", ylab = "Average Rate")
title(main = "Average Rate against Employment") 

#predict
y <- predict(IMD.model,newdata = DeprivationData2)
plot(y ~ IMD, type = "n", data = DeprivationData2, 
     xlab = "IMD", ylab = "AverageRate")
predictmodel <- lm(y ~ IMD, data = DeprivationData2)
actualmodel <- lm(AverageRate ~ IMD, data = DeprivationData2)
abline(predictmodel, lwd = 1, col = "blue", lty = 1)
abline(actualmodel, lwd = 1, col = "red", lty = 1)
title(main = "Prediction using wave 1 model")  


