library("RColorBrewer")
library(plotly)
library(ggplot2)
library(vegan)
library(mxmaps)
library(leaflet)
library(plyr)
library(dplyr)
library(tidyr)
library(reshape)

#setwd("~/Dropbox/JANO/2016/Conabio/Agrobiodiversidad_Regionales/Datos SAGARPA/")
Municipios <- read.csv("Cultivos_de_Tu_Municipio_2015.csv", header = T, sep = "," , dec = ".")
head(Municipios)
names(Municipios) <- c("Clav.Entid", "Entidad", "Clav.Mun", "Municipio", "ProducID", "Cultivo", "SupCosechHa", "VolProd_Ton", "VolProd_Pesos", "VolProd_SupCosech")
names(Municipios)

Municipios$Clav.Mun <- sprintf("%03d", Municipios$Clav.Mun)
Municipios$Clav.Entid <- sprintf("%02d", Municipios$Clav.Entid)

head(Municipios)
IDCode <- paste(Municipios$Clav.Entid, Municipios$Clav.Mun, sep = "")

Municipios <- data.frame(IDCode, Municipios)

head(Municipios)
names(Municipios)[1] <- c("region")
str(Municipios)

data("df_mxmunicipio")
head(df_mxmunicipio)
dim(df_mxmunicipio)

#Solo valores con pvalue de beta < 0.05
TTT <- df_mxmunicipio[,1:8]
head(TTT)
str(TTT)

#Para el Area
MxMunicipios <- merge(TTT, Municipios, by = "region")
#MxMunicipios <- merge(TTT, AreaT2, by = "region")

dim(MxMunicipios)
dim(df_mxmunicipio)
dim(Municipios)

names(Municipios)
head(MxMunicipios)
names(MxMunicipios)
#names(MxMunicipios)[9] <- c("value")
#names(MxMunicipios)[11] <- c("beta")
#la columna 15 es supCosechHa
names(MxMunicipios)[15] <- c("value")

summary(MxMunicipios$Cultivo)
MxMunicipios1 <- MxMunicipios
#df_mxmunicipio$value <-  df_mxmunicipio$indigenous / df_mxmunicipio$pop 
names(MxMunicipios1)


MxMunicipios4 <- data.frame(MxMunicipios1$state_name, MxMunicipios1$Cultivo, rep(1, nrow(MxMunicipios1)))
names(MxMunicipios4) <- c("Estados", "Cultivos", "value")

MxMunicipios5 <- cast(MxMunicipios4, Estados~Cultivos)


####### Rarefraccion
RarefraccionCC <- function(Tabla,factor){
  require(vegan)
  Tabla1 <- data.frame(Tabla, row.names = factor)
  raremax <- min(rowSums(Tabla1))
  col1 <- seq(1:nrow(Tabla1)) #Para poner color a las lineas
  lty1 <- c("solid","dashed","longdash","dotdash")
  rarecurve(Tabla1, sample = raremax, col = "black", lty = lty1, cex = 1.2)
  #Para calcular el numero de especies de acuerdo a rarefraccion
  UUU <- rarefy(Tabla1, raremax)
  print(UUU)
}

RarefraccionCC(MxMunicipios5[,-1],MxMunicipios5[,1])


#############################################
####Para Calcular Renyi#######
#Variable "Tabla" debe tener el mismo numero de renglones que la variable "factor"
#Variable "factor" debe tener distinto nombre

RenyiCC <- function(Tabla, factor){
  require(vegan) #Paquete para la funcion "renyi"
  require(ggplot2)#Paquete para hacer la funcion "qplot"
  require(reshape)#Paquete para la funcion "melt"
  Tabla <- data.frame(Tabla, row.names=factor)
  mod <- renyi(Tabla)
  vec <- seq(1:11)
  mod1 <- data.frame(vec,t(mod))
  mod2 <- melt(mod1, id=c("vec"))
  mod2
  #mod2$variable <- as.numeric(mod2$variable)
  orange <- qplot(vec, value, data = mod2, colour = variable, geom = 	"line")+theme_bw()
  orange+scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11), 		labels=c("0","0.25","0.5","1","2","4","8","16","32","64","Inf"))
}

RenyiCC(MxMunicipios5[,-1],MxMunicipios5[,1])



