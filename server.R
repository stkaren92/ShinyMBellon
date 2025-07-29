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
   
   return(Tabla1)

  })
    
  MxMunicipios2 <- reactive({
    TablaH <- MxMunicipios1()
    value <- decostand(TablaH[,input$Variable1], "normalize")
    TablaH <- data.frame(TablaH, value)
    TablaH$state_name <- as.factor(TablaH$state_name)
    
    return(TablaH)
  })
  
  MxMunicipios_sf <- reactive({
    HHH1 <- MxMunicipios2()
    
    if (input$State1 != "All") {
      MxMunicipios_sf <- sf_mun[sf_mun$NOM_ENT==input$State1,]
    }else MxMunicipios_sf <- sf_mun
    
    MxMunicipios_sf <- MxMunicipios_sf %>%
      left_join(HHH1, by = c("CVE_MUN" = "municipio_code",
                             "CVE_ENT" = "state_code"))
    
    return(MxMunicipios_sf)
  })
  
  output$mymap <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      setView(lng=-99, lat=23, 5.5) %>% 
      addLegend(colors = c("#3068b2","#bf3750","#050505"), position = "topleft", 
                labels = c("Surplus of <br>maize", "Deficit of <br>maize","No data"),
                opacity = c(0.1, 0.1, 0.1)) %>%
      addProviderTiles("CartoDB.Positron")
  })
  # Updates map
  observe({
    # Show the loading panel
    shinyjs::show("loading")
    
    MxMunicipios_sf <- MxMunicipios_sf()
    
    pal <- colorNumeric(c(rev(brewer.pal(3, "Reds")),brewer.pal(3, "Blues")),
                        domain = c(-1,1))
    
    popup_text <- sprintf("IdCode: %s<br/>State: %s<br/>Municipio: %s<br/>AreaPlantada: %s ha <br/>Producción: %s t<br/>Rendimiento: %s t<br/>Pob. Total: %s people <br/>Pob. Rural: %s people<br/>SurPlusTPobl: %s t<br/>SurPlusPob. Rural: %s t",
                     MxMunicipios_sf$region,
                     MxMunicipios_sf$state_name, 
                     MxMunicipios_sf$municipio_name, 
                     MxMunicipios_sf$aplt2010, 
                     MxMunicipios_sf$prod2010, 
                     MxMunicipios_sf$rend2010, 
                     MxMunicipios_sf$POBTOT10, 
                     MxMunicipios_sf$Pob_rur10, 
                     round(MxMunicipios_sf$Total), 
                     round(MxMunicipios_sf$Rural))
    
    leafletProxy("mymap") %>%
      clearShapes() %>%
      setView(lng=-99, lat=23, 5.5) %>% 
       addPolygons(data=MxMunicipios_sf,
                  fillColor = ~pal(value),
                  popup = ~popup_text,
                  fillOpacity = 0.8,
                  weight=.2, 
                  color="#555555")
    
  })
  
})
