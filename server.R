shinyServer(function(input, output) {
  
  MxMunicipios1 <- reactive({
    
    if (input$State1 != "All") {
      MxMunicipios <- MxMunicipios[MxMunicipios$state_name %in% input$State1,]
    }else MxMunicipios <- MxMunicipios
    
   prod2010a <- MxMunicipios$prod2010 
   
   PerCapitaL <- (input$PerCapita*365)/1000
   
   Rural <- (prod2010a * (1 - (input$Loss/100))) -  (MxMunicipios$Pob_rur10 * PerCapitaL)
   Total <- (prod2010a * (1 - (input$Loss/100))) -  (MxMunicipios$POBTOT10 * PerCapitaL)
   
   Tabla1 <- data.frame(MxMunicipios, Total, Rural) 

  })
    
  MxMunicipios2 <- reactive({
    TablaH <- MxMunicipios1()
    value <- decostand(TablaH[,input$Variable1], "normalize")
    TablaH <- data.frame(TablaH, value)
  })
  
  output$mymap <- renderLeaflet({
    HHH1 <- MxMunicipios2()
    HHH1$state_name <- as.factor(HHH1$state_name)
    HHH <- c(rev(brewer.pal(3, "Reds")),brewer.pal(3, "Blues"))
    
    pal <- colorNumeric(HHH, domain = HHH1$value)
    
    pal1 <- colorNumeric('OrRd', 2)
    
    mxmunicipio_leaflet(HHH1,
                        pal, 
                        mapzoom = 6,
                        ~pal(value),
                        fillOpacity = 1,
                        ~ sprintf("IdCode: %s<br/>State: %s<br/>Municipio: %s<br/>AreaPlantada: %s ha <br/>Producción: %s t<br/>Rendimiento: %s t<br/>Pob. Total: %s people <br/>Pob. Rural: %s people<br/>SurPlusTPobl: %s t<br/>SurPlusPob. Rural: %s t",
                                  region,state_name, municipio_name, aplt2010, prod2010, rend2010, POBTOT10, Pob_rur10, round(Total), round(Rural))) %>%
      
      # Add common legend
      addLegend(colors = c("#3068b2","#bf3750","#050505"), position = "topleft", 
                labels = c("Surplus of <br>maize", "Deficit of <br>maize","No data"),
                opacity = c(0.1, 0.1, 0.1)) %>%
      
        addProviderTiles("CartoDB.Positron") 
    
  }
  )
  
})
