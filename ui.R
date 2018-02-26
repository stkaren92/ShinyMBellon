library(shiny)
library(knitr)

             #Application title
             
             
             #tags$a(href = "http://www.sagarpa.gob.mx/quienesomos/datosabiertos/siap/Paginas/Catalogos.aspx", "Base de Datos"),
      
                 
                 
    
             bootstrapPage(tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
                           div(img(src = "CONABIO_LOGO_13.JPG", width = "100"), style = "text-align: center;"),
            
                           h3("Reconsidering the contributions of Mexican ", tags$i("campesino"), "to the ongoing evolution of maize under domesticación and to national food supply", style = "text-align: center;"),
                           h4("Supporting information: A visualization of surplus (blue) or deficit (red) of maize at Municipal level in México"),
                           #h4("Interactive Shiny application with R were performed with data of figure 2. Spatial distribution of the contribution of local rainfed maize production to feed population (rural or total) in the municipalities where maize is produced. Red and blue colors indicates a deficit and surplus, respectively of maize."),
                           #h4("Bellon M.R., et al. 2018"),
                           
                leafletOutput("mymap", width = "100%", height = "100%"),
                absolutePanel(top = 190, right = 34,
                      
                              numericInput('PerCapita',h5('Daily Per-Capita Consumption (kg):'), 0.23782, min = 0, max = 1),
                              
                              numericInput('Loss', h5('Post-harvest losses (%):'), 0.25, min = 0, max = 1),
                              
                              selectInput(inputId = "Variable1",
                                          label = h5("Population:"), choices = VAL,
                                          selected = "Rural"),
                  
                              selectInput(inputId = "State1",
                                          label = h5("States:"), 
                                          c("All", levels(MxMunicipios$state_name))
                              ),
                              
                              
                              submitButton("Submit")
                      
                              
                              
                              ),
                absolutePanel(bottom = -190, left = 1,
                              h4("Database:"),
                              tags$a(href = "https://datadryad.org/", "Dryad"),
                              h4("Code:"),
                              tags$a(href = "https://github.com/APonce73/ShinyMBellon", "Github"),
                              
                              
                              br(),
                              h5("comments:"),
                              h5("aponce@conabio.gob.mx")
                  
                )
             )

