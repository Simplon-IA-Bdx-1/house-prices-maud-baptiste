# on récup les donnée numérique 
# setwd("C:/Users/utilisateur/Desktop/projet_appliquer/house")
# df<-as.data.frame(read.csv("kaggle-house-prices-train.csv", header=TRUE), row.names(1))
#nums <- unlist(sapply(df, is.numeric))

#df_nums <- df[,nums]

#df_nums              


#ncol(df_nums)
#library(car)
#reg.multiple2 <-lm(as.formula(paste(colnames(df_nums)[38], "~",
                                               paste(colnames(df_nums)[c(2:37)], collapse = "+"),
                                               sep = ""
                                               )), data = df_nums)
#vif(reg.multiple2)

#summary(reg.multiple2)


#reg.multipleOptimale <-step(reg.multiple2, direction = "backward")


#reg.multipleopt <-lm(SalePrice ~ MSSubClass + LotFrontage + LotArea + OverallQual + 
#                       OverallCond + YearBuilt + YearRemodAdd + MasVnrArea + BsmtFinSF1 + 
#                       BsmtFinSF2 + BsmtUnfSF + X1stFlrSF + X2ndFlrSF + LowQualFinSF + 
#                       BsmtFullBath + FullBath + BedroomAbvGr + KitchenAbvGr + TotRmsAbvGrd + 
#                       Fireplaces + GarageYrBlt + GarageCars + WoodDeckSF + X3SsnPorch + 
#                       ScreenPorch + PoolArea + MiscVal, data = df_nums)
#vif(reg.multipleopt)

#summary(reg.multipleopt)
                                               
library(dplyr)  
head(houset)                                               
train_nums <- select_if(houset, is.numeric)
head(train_nums)
colSums(train_nums == 0, na.rm=T)
                                               
reg.SalePrice <- lm(SalePrice~., data=train_nums)
summary(reg.SalePrice)
par(mfrow=c(1,1))
# sup alias
alias(reg.SalePrice)      
train_nums$TotalBsmtSF<- NULL
train_nums$GrLivArea<- NULL
vif_SP <- vif(reg.SalePrice)
sort(vif_SP)

library(corrplot)
corrplot(cor(train_nums))

reg.multipleOptimale <-step(reg.SalePrice, direction = "backward")


reg.SalePriceOpt <- lm(SalePrice ~ MSSubClass + LotFrontage + LotArea + OverallQual + 
                         OverallCond + YearBuilt + YearRemodAdd + MasVnrArea + BsmtFinSF1 + 
                         BsmtFinSF2 + BsmtUnfSF + X1stFlrSF + X2ndFlrSF + LowQualFinSF + 
                         BsmtFullBath + FullBath + BedroomAbvGr + KitchenAbvGr + TotRmsAbvGrd + 
                         Fireplaces + GarageYrBlt + GarageCars + WoodDeckSF + X3SsnPorch + 
                         ScreenPorch + PoolArea + MiscVal, data = train_nums)


summary(reg.SalePriceOpt)
vif_SP <- vif(reg.SalePriceOpt)
sort(vif_SP)

reg.SalePriceOpt2 <- lm(SalePrice ~X3SsnPorch + MiscVal + LowQualFinSF + ScreenPorch + 
                          PoolArea + WoodDeckSF + LotArea + MasVnrArea + BsmtFinSF2 +  
                          Fireplaces + KitchenAbvGr +  MSSubClass + OverallCond + 
                          LotFrontage + BsmtFullBath + BedroomAbvGr + GarageCars + 
                          FullBath + YearRemodAdd + OverallQual, data= train_nums) 

summary(reg.SalePriceOpt2)
vif_SP2 <- vif(reg.SalePriceOpt2)
sort(vif_SP2)

reg.multipleOptimale <-step(reg.SalePriceOpt2, direction = "backward")

reg.SalePriceOpt3 <- lm(SalePrice ~ LowQualFinSF + ScreenPorch + WoodDeckSF + LotArea + 
  MasVnrArea + Fireplaces + MSSubClass + OverallCond + LotFrontage + 
  BsmtFullBath + BedroomAbvGr + GarageCars + FullBath + YearRemodAdd + 
  OverallQual, data= train_nums)


summary(reg.SalePriceOpt3)
vif_SP3 <- vif(reg.SalePriceOpt3)
sort(vif_SP3)
