library(shiny)

shinyServer(function(input, output) {
  
  points1 <- reactive({
  
    if (input$Cultivo != "All") {
      Tabla1 <- MxMunicipios1[MxMunicipios1$Cultivo %in% input$Cultivo,]
    }else {Tabla1 <- MxMunicipios1
    }
    #value <- Tabla1[,Tabla1$Variables %in% input$Variables]
    #Tabla1 <- data.frame(Tabla1, value)
    
  })
    
  
  #Para la tabla en csv
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("tabla", '.csv', sep = '')},
    content = function(file){
      write.csv(points1(), file)
    }
  )
    
#  MxMunicipios2 <- HHH %>%
#    filter(Cultivo == "Higo")
#  
#  mxmunicipio_choropleth(MxMunicipios2, 
#                         num_colors = 1,
#                         title = "Superficie cosechada")
  
  
  #For do a zoom
  #head(MxMunicipios)
  #mxmunicipio_choropleth(MxMunicipios2, num_colors = 1,
  #                       zoom = subset(MxMunicipios2, state_name %in% c("Morelos","Hidalgo","Ciudad de México"))$region,
  #                       title = "Valor de Beta, ?rea sembrada con ma?z in South East of M?xico") 
  
  
  output$mymap <- renderLeaflet({
    MxMunicipios2 <- points1()
    
    MxMunicipios3 <- merge(TTT, MxMunicipios2[,c(1,14:18)], by = "region", all.x = T)
    dim(MxMunicipios3)
    head(MxMunicipios3)
    #HHH <- brewer.pal(12, "Paired")
    #HHH <- c("white",brewer.pal(1, "Accent"),brewer.pal(6, "Reds"))
    HHH <- c("white",brewer.pal(6, "Reds"))
    MxMunicipios3$value[is.na(MxMunicipios3$value)] <- 0
    
    pal <- colorNumeric(HHH, domain = MxMunicipios3$value)
    
    #head(MxMunicipios2)
    
    mxmunicipio_leaflet(MxMunicipios3,
                        pal,
                        ~ pal(value), mapzoom = 6,
                        ~ sprintf("Cultivo: %s<br/>State: %s<br/>Municipio: %s<br/>Sup Sembrada (ha): %s<br/>Vol. Producción (Ton): %s <br/>Vol. Prod $: %s",
                                  Cultivo,state_name, municipio_name, round(value,3), VolProd_Ton, VolProd_Pesos)) %>%
      addLegend(position = "topright", pal = pal, values = MxMunicipios3$value,
                title = "Superficie<br>Sembrada (ha)") %>%
      addProviderTiles("CartoDB.Positron") 
    
  }
  )
  
  ####################################
  # Ventana de Diversidad
  Narbat1 <- reactive({
    
    TableL4 <- MxMunicipios5
    
  })
  # 
  
  
  output$Rarefraction <- renderPlot({
    TableL5 <- Narbat1()
    #TableL5 <- aggregate(Narbat2[,-1],list(Narbat2[,1]), FUN = sum, na.rm = T)
    
    
    LL35 <- RarefraccionCC(TableL5[,-c(1)], TableL5[,1])
    return(LL35)
  })
  
  
  output$Renyi1 <- renderPlotly({
    TableL5 <- Narbat1()
    #TableL5 <- aggregate(Narbat2[,-1],list(Narbat2[,1]), FUN = sum, na.rm = T)
    
    
    LL35 <- RenyiCC(TableL5[,-c(1)], TableL5[,1])
    #return(LL35)
    gg <- ggplotly(LL35)
    gg
  })
  
  
})
