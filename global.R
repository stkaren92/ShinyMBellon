library(dplyr)
library(leaflet)
library(mxmaps)
library(RColorBrewer)
library(shiny)
library(tidyverse)
library(vegan)

Municipios <- read.delim("data/DatosShiny.csv", header = T, sep = "," , dec = ".")

Municipios$Idcode <- sprintf("%05d", Municipios$Idcode)

names(Municipios)[1] <- c("region")

Municipios <- Municipios %>%
  filter(!is.na(region)) %>%
  filter(!is.na(Categorie)) 

data("df_mxmunicipio")

#Solo valores con pvalue de beta < 0.05
TTT <- df_mxmunicipio[,c(1:8,16)]

#Para el Area
MxMunicipios <- merge(TTT, Municipios, by = "region")

MxMunicipios$state_name <- as.factor(MxMunicipios$state_name)
MxMunicipios$Categorie <- as.factor(MxMunicipios$Categorie)

VAL <- c("Total", "Rural")
