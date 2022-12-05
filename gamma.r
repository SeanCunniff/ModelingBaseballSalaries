library(MASS)
library(rcompanion)
df <- read.csv("./dataset.csv")
df$AAV_k <- df$AAV / 100000
plotNormalHistogram(df$AAV_k)
#GAMMA Regressions
summary(
    fitted.model<- glm(
        AAV_k ~ age + OPS_ + oWAR + dWAR + SO,
        data=df,
        family=Gamma(link=log)))

null.model<- glm(
    df$AAV_k ~ 1, 
    family=Gamma(link=log))
print(deviance<- -2*(logLik(null.model)-logLik(fitted.model)))
print(p.value<- pchisq(deviance, df=5, lower.tail=FALSE))

#predictions
#Bogaerts 
print(predict(
    fitted.model,
    data.frame(age = 29, oWAR = 12.7, dWAR = 1.5, OPS_ = 129, SO = 272),
    type="response"
))

#Correa
print(predict(
    fitted.model,
    data.frame(age = 27, oWAR = 11.3, dWAR = 5.0, OPS_ = 128, SO = 286),
    type="response"
))
