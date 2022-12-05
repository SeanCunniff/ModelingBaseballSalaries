library(MASS)
library(rcompanion)
df <- read.csv("./dataset.csv")
df$AAV_k <- df$AAV / 100000
plotNormalHistogram(df$AAV_k)
shapiro.test(df$AAV_k)
#Calculating Lambda
BoxCox.fit<- boxcox(AAV_k ~ age + OPS_ + oWAR + dWAR + SO, 
                    data=df, lambda = seq(-3,3,1/4), interp=FALSE)
BoxCox.data<- data.frame(BoxCox.fit$x, BoxCox.fit$y)
ordered.data<- BoxCox.data[with(BoxCox.data, order(-BoxCox.fit.y)),]
ordered.data[1,]
#Transformation
df$AAV_tr <- 2*(sqrt(df$AAV_k)-1)
plotNormalHistogram(df$AAV_tr)
shapiro.test(df$AAV_tr)
#Checking fit
summary(fitted.model <- glm(
    df$AAV_tr ~ age + OPS_ + oWAR + dWAR + SO, data=df, 
    family=gaussian(link=identity)))
sigma(fitted.model)
null.model<- glm(df$AAV_tr ~ 1, family=gaussian(link=identity))
print(deviance<- -2*(logLik(null.model)-logLik(fitted.model)))
print(p.value<- pchisq(deviance, df=5, lower.tail=FALSE))
#Predictions
#Bogaerts
x <- predict(
    fitted.model,
    data.frame(age = 29, oWAR = 12.7, dWAR = 1.5, OPS_ = 129, SO = 272),
    type="response")
print((.5*x+1)^2)
#Correa
y <- predict(
    fitted.model,
    data.frame(age = 27, oWAR = 11.3, dWAR = 5.0, OPS_ = 128, SO = 286),
    type="response"
)
print((.5*y+1)^2)

