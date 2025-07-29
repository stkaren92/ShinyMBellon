library(dplyr)
library(leaflet)
library(mxmaps)
library(RColorBrewer)
library(shiny)
library(tidyverse)
library(vegan)
library(sf)

sf_mun <- read_sf('data/mun22gw/mun22gw.shp')
Municipios <- read.delim("data/DatosShiny.csv", header = T, sep = "," , dec = ".")
data("df_mxmunicipio")

Municipios$Idcode <- sprintf("%05d", Municipios$Idcode)

names(Municipios)[1] <- c("region")

Municipios <- Municipios %>%
  filter(!is.na(region)) %>%
  filter(!is.na(Categorie)) 

#Solo valores con pvalue de beta < 0.05
TTT <- df_mxmunicipio[,c(1:8,16,19,18)]

#Para el Area
MxMunicipios <- merge(TTT, Municipios, by = "region")

MxMunicipios$state_name <- as.factor(MxMunicipios$state_name)
MxMunicipios$Categorie <- as.factor(MxMunicipios$Categorie)

VAL <- c("Total", "Rural")

#Cambiar nombre de estados 
sf_mun[sf_mun$NOM_ENT == "Coahuila de Zaragoza",]$NOM_ENT <- "Coahuila"
sf_mun[sf_mun$NOM_ENT == "Michoacán de Ocampo",]$NOM_ENT <- "Michoacán"
sf_mun[sf_mun$NOM_ENT == "Veracruz de Ignacio de la Llave",]$NOM_ENT <- "Veracruz"
