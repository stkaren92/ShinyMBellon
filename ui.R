bootstrapPage(tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
              div(img(src = "CONABIO_LOGO_13.JPG", width = "100"), style = "text-align: center;"),
              
              h3("Reconsidering the contributions of Mexican ", tags$i("campesino"), "to the ongoing evolution of maize under domesticación and to national food supply", style = "text-align: center;"),
              h4("Supporting information: A visualization of surplus (blue) or deficit (red) of maize at Municipal level in México."),
              h4("Maize values are for rainfed agricultural season (May-October) of 2010 from", tags$a(href = "http://infosiap.siap.gob.mx/aagricola_siap_gb/icultivo/", "SIAP.")),
              
              leafletOutput("mymap", width = "100%", height = "100%"),
              
              absolutePanel(top = 190, right = 34,
                            
                            numericInput('PerCapita',h5('Daily Per-Capita Consumption (kg):'), 0.23782, min = 0, max = 1),
                            
                            numericInput('Loss', h5('Post-harvest losses (%):'), 25, min = 0, max = 100),
                            
                            selectInput(inputId = "Variable1",
                                        label = h5("Population:"), 
                                        choices = VAL,
                                        selected = "Rural"),
                            
                            selectInput(inputId = "State1",
                                        label = h5("States:"), 
                                        choices = c("All", levels(MxMunicipios$state_name)),
                                        selected = "Aguascalientes"),
                            
                            
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

