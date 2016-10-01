library(shiny)


shinyUI(navbarPage(
  title = "Mauricio Bellon paper",
  

  
  tabPanel('Mapa', 
           # Define UI for slider demo application
           shinyUI(fluidPage(
             #Application title
             titlePanel("Debunking Myth"),
             h4("Suplementary analysis for the article Bellon et al., 2016"),
             #tags$a(href = "http://www.sagarpa.gob.mx/quienesomos/datosabiertos/siap/Paginas/Catalogos.aspx", "Base de Datos"),
             
             sidebarLayout(
               sidebarPanel(
                 
                 numericInput('PerCapita','Daily Per-Capita Consumption (kg):', 0.23782, min = 0, max = 1),
                 
                 numericInput('Loss','Post-harvest losses:', 0.25, min = 0, max = 1),
                
                 selectInput(inputId = "Variable1",
                             label = h6("Variable:"), choices = VAL,
                             selected = "SurplusRuralPobl"),
                 submitButton("Submit"),
                 #selectInput(inputId = "Variable1",
                  #           label = h6("Variable:"), choices = names(MxMunicipios1)[15:18],
                  #           selected = names(MxMunicipios1)[1]),
                             
                br(),
                br(),
                downloadButton('downloadData', 'Download como csv'),
                
                br(),
                h5("comments: aponce@conabio.gob.mx or aponce73pm@gmail.com"),
                #br(),
                h4("Github:"),
                tags$a(href = "https://github.com/APonce73/SagarpaShiny", "Cultivos"),
                
                
                 #c("All", unique(as.character(TableL$Raza_primaria)))),
                 
                 
                 
                 width = 2),
               fluidRow(
                 #verbatimTextOutput("summary"),
                 column(9,leafletOutput("mymap", width = "1300", height = "1000"))
               )
               #leafletOutput("mymap", width = "100%", height = "100%")
             )
           )) 
  )
  
))

