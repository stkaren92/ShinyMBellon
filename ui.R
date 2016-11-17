library(shiny)
library(knitr)


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
                 
                 numericInput('PerCapita',h5('Daily Per-Capita Consumption (kg):'), 0.23782, min = 0, max = 1),
                 
                 numericInput('Loss', h5('Post-harvest losses:'), 0.25, min = 0, max = 1),
                
                 selectInput(inputId = "Variable1",
                             label = h5("Variable:"), choices = VAL,
                             selected = "SurplusRuralPobl"),
                 
                 selectInput(inputId = "State1",
                             label = h5("State:"), 
                             c("All", levels(MxMunicipios$state_name))
                             ),
                 
                 checkboxGroupInput("Categorie1", label = h6("Categorie (Ton/ha):"),
                                    choice = levels(MxMunicipios$Categorie), selected = levels(MxMunicipios$Categorie)),
                 
                 br(),
                 numericInput('Loss1',h5('losses on field (%):'), 0, min = 0, max = 100),
                
                br(),  
                submitButton("Submit"),
                 
                br(),
                br(),
                downloadButton('downloadData', 'Download como csv'),
                
                br(),
                h5("comments: aponce@conabio.gob.mx"),
                h5("aponce73pm@gmail.com"),
                br(),
                h4("Code:"),
                tags$a(href = "https://github.com/APonce73/ShinyMBellon", "Github"),
                
                
                 #c("All", unique(as.character(TableL$Raza_primaria)))),
                 
                 
                 
                 width = 2),
               fluidRow(
                 #verbatimTextOutput("summary"),
                 column(9,leafletOutput("mymap", width = "1200", height = "800"))
               )
               #leafletOutput("mymap", width = "100%", height = "100%")
             )
           )) 
  )
  
))

