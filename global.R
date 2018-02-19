library(RColorBrewer)
library(tidyverse)
#library(ggplot2)
library(vegan)
library(mxmaps)
library(leaflet)
#library(plyr)
#library(dplyr)
#library(tidyr)
library(reshape)


#setwd("~/Dropbox/GitHub/ShinyMBellon/")
Municipios <- read.delim("DatosShiny.csv", header = T, sep = "," , dec = ".")
head(Municipios)

levels(as.factor(Municipios$rend2010))

Municipios$rend2010

Municipios$Idcode <- sprintf("%05d", Municipios$Idcode)
dim(Municipios)
head(Municipios)

names(Municipios)[1] <- c("region")
str(Municipios)
tail(Municipios,50)

names(Municipios)
dim(Municipios)
Municipios <- Municipios %>%
  filter(!is.na(region)) %>%
  filter(!is.na(Categorie)) 


  #slice((rend2010 > 3))
  #filter(!is.na(aplt2010))

#head(Municipios1)


#Municipios1$rend2010

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
MxMunicipios$Categorie <- as.factor(MxMunicipios$Categorie)

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


VAL <- c("Total", "Rural")

