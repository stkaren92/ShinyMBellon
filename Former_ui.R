library(shiny)
library(knitr)



shinyUI(
  #navbarPage(
  #title = "Mauricio Bellon paper",
  
  
  
  #tabPanel('Mapa', 
           # Define UI for slider demo application
           shinyUI(fluidPage(
             #Application title
             div(img(src = "CONABIO_LOGO_13.JPG", width = "150"), style = "text-align: center;"),
             br(),
             titlePanel("De-bunking the myth of the unproductive Mexican campesino maize farmer"),
             h4("Interactive Shiny application with R were performed with data of figure 2. Spatial distribution of the contribution of local rainfed maize production to feed population (rural or total) in the municipalities where maize is produced. Red and blue colors indicates a deficit and surplus, respectively of maize."),
             h4("Bellon M.R., et al. 2018"),
             
             #tags$a(href = "http://www.sagarpa.gob.mx/quienesomos/datosabiertos/siap/Paginas/Catalogos.aspx", "Base de Datos"),
             
             sidebarLayout(
               sidebarPanel(
                 
                 numericInput('PerCapita',h5('Daily Per-Capita Consumption (kg):'), 0.23782, min = 0, max = 1),
                 
                 numericInput('Loss', h5('Post-harvest losses (%):'), 0.25, min = 0, max = 1),
                
                 selectInput(inputId = "Variable1",
                             label = h5("Population:"), choices = VAL,
                             selected = "Rural"),
                 
                 selectInput(inputId = "State1",
                             label = h5("States:"), 
                             c("All", levels(MxMunicipios$state_name))
                             ),
                 
                # checkboxGroupInput("Categorie1", label = h6("Categorie (Ton/ha):"),
                #                    choice = levels(MxMunicipios$Categorie), selected = levels(MxMunicipios$Categorie)),
                 
                 #br(),
                 #numericInput('Loss1',h5('losses on field (%):'), 0, min = 0, max = 100),
                
                #br(),  
                submitButton("Submit"),
                 
                #downloadButton('downloadData', 'Download como csv'),
                
                br(),
                h4("Database:"),
                tags$a(href = "https://datadryad.org/", "Dryad"),
                h4("Code:"),
                tags$a(href = "https://github.com/APonce73/ShinyMBellon", "Github"),
                
                
                br(),
                h5("comments: aponce@conabio.gob.mx"),
                h5("aponce73pm@gmail.com"),
                
                 #c("All", unique(as.character(TableL$Raza_primaria)))),
                 width = 2),
               fluidRow(
                 #verbatimTextOutput("summary"),
                 column(9, leafletOutput("mymap", width = "1200", height = "800")),
                 br(),
                 column(8, h4("Maize consumption could be different for regions. For the article maize consume per capita by CENEVAL was used: 237 g-1 person -1 day -1. 
                              But, other reports as Ranum et al. (2014) with 267 g-1 person -1 day -1 or Stuart (1990) with 370 g-1 person -1 day -1, 
                              could be used in the shiny. Additional information on supplementary Table S6"))
               )
               
               
               #leafletOutput("mymap", width = "100%", height = "100%")
             )
           )) 
 # )
  
#)
)

