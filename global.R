library(RColorBrewer)
library(plotly)
library(ggplot2)
library(vegan)
library(mxmaps)
library(leaflet)
library(plyr)
library(dplyr)
library(tidyr)
library(reshape)
library(vegan)

#setwd("~/Dropbox/GitHub/ShinyMBellon/")
Municipios <- read.delim("DatosShiny.csv", header = T, sep = "," , dec = ".")
head(Municipios)

Municipios$Idcode <- sprintf("%05d", Municipios$Idcode)
dim(Municipios)
head(Municipios)

names(Municipios)[1] <- c("region")
str(Municipios)
tail(Municipios,50)

dim(Municipios)
Municipios <- Municipios %>%
  filter(!is.na(region))
  #filter(!is.na(aplt2010))

dim(Municipios)

data("df_mxmunicipio")
head(df_mxmunicipio)



head(df_mxmunicipio)
dim(df_mxmunicipio)
#Solo valores con pvalue de beta < 0.05
TTT <- df_mxmunicipio[,c(1:8,16)]
head(TTT)
str(TTT)

#Para el Area
MxMunicipios <- merge(TTT, Municipios, by = "region")
head(MxMunicipios)

MxMunicipios$state_name <- as.factor(MxMunicipios$state_name)
#MxMunicipios10 <- MxMunicipios %>%
#  group_by(prod2010 <= 1000)


#head(MxMunicipios10)
#MxMunicipios <- merge(TTT, AreaT2, by = "region")
#value <- MxMunicipios$POBTOT10

#MxMunicipiosLL <- data.frame(MxMunicipios, value)
#head(MxMunicipios)
#View(MxMunicipios)


#PerCapitaL <- ((0.34*365)*(1 + 0.23))/1000

#SurplusRuralPobl <- MxMunicipios$prod2010 -  (MxMunicipios$Pob_rur10 * PerCapitaL)
#SurplusTotalPobl <- MxMunicipios$prod2010 -  (MxMunicipios$POBTOT10 * PerCapitaL)

#Tabla1 <- data.frame(MxMunicipios[,], SurplusTotalPobl, SurplusRuralPobl)  
#head(Tabla1)


VAL <- c("SurplusTotalPobl", "SurplusRuralPobl")

