library(shiny)

shinyServer(function(input, output) {
  
  MxMunicipios1 <- reactive({
   
   PerCapitaL <- ((input$PerCapita*365)*(1 + input$Loss))/1000
   
   SurplusRuralPobl <- MxMunicipios$prod2010 -  (MxMunicipios$Pob_rur10 * PerCapitaL)
   SurplusTotalPobl <- MxMunicipios$prod2010 -  (MxMunicipios$POBTOT10 * PerCapitaL)
  
   Tabla1 <- data.frame(MxMunicipios, SurplusTotalPobl, SurplusRuralPobl)  
   
  })
    
  
  #Para la tabla en csv
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("tabla", '.csv', sep = '')},
    content = function(file){
      write.csv(MxMunicipios1(), file)
    }
  )
    

  MxMunicipios2 <- reactive({
    TablaH <- MxMunicipios1()
    value <- decostand(TablaH[,input$Variable1], "normalize")
    TablaH <- data.frame(TablaH, value)
  })
  
  output$mymap <- renderLeaflet({
    HHH1 <- MxMunicipios2()
    
    #MxMunicipios3 <- merge(TTT, MxMunicipios2[,c(1,14:18)], by = "region", all.x = T)
    #value <- c(MxMunicipios2$input %in% input$Variable1)
    #MxMunicipios3 <- data.frame(MxMunicipios2, value)
    #MxMunicipios3 <- MxMunicipiosLL
    
    #HHH <- brewer.pal(12, "")
    HHH <- c(rev(brewer.pal(2, "Reds")),brewer.pal(2, "Blues"))
    #HHH <- c("white",brewer.pal(6, "Reds"))
    #MxMunicipios3$value[is.na(MxMunicipios3$value)] <- 0
    
    pal <- colorNumeric(HHH, domain = HHH1$value)
    
    #head(MxMunicipios2)
    
    mxmunicipio_leaflet(HHH1,
                        pal,
                        ~pal(value), mapzoom = 6,
                        ~ sprintf("IdCode: %s<br/>State: %s<br/>Municipio: %s<br/>Producción: %s<br/>Pob. Total: %s<br/>Pob. Rural: %s<br/>SurPlusTPobl: %s<br/>SurPlusPob. Rural: %s",
                                  region,state_name, municipio_name, prod2010, POBTOT10, Pob_rur10, round(SurplusTotalPobl), round(SurplusRuralPobl))) %>%
      addLegend(position = "topright", pal = pal, values = HHH1$value,
                title = "variable<br>Seleccionada") %>%
      addProviderTiles("CartoDB.Positron") 
    
  }
  )
  
#  output$summary <- renderPrint({
#    dataset <- MxMunicipios2()
#    summary(dataset[,15:ncol(dataset)],3)
#  })
  
  ####################################
  
  
})
