
summary(risque)

logistique.res <-glm(risque~depression + anxiete, data=risque, family="binomial")
summary(logistique.res)


plot(risque$depression, risque$risque)

cor(risque$depression, risque$anxiete)


library(corrplot)
corrplot(cor(risque))

#risque$risque <-as.factor(risque$risque)
#risque$risque <-aarrange(risque$risque)

qplot(risque, depression, data = risque, geom="boxplot")

qplot(risque, anxiete, data = risque, geom="boxplot")

reslog<- glm(risque~depression, newdata=risque, type="response")
library(visreg)
visreg(reslog)
predicted= predict(reslog, risque, type="response")
plot(risque$depression, predicted, col= )