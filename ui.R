library(shiny)


shinyUI(navbarPage(
  title = "Cultivos en México",
  

  
  tabPanel('Mapa', 
           # Define UI for slider demo application
           shinyUI(fluidPage(
             #Application title
             titlePanel("Cultivos reportados por Sagarpa"),
             h4("Los valores son del Sistema de Información Agroalimentaria y Pesquera"),
             tags$a(href = "http://www.sagarpa.gob.mx/quienesomos/datosabiertos/siap/Paginas/Catalogos.aspx", "Base de Datos"),
             
             sidebarLayout(
               sidebarPanel(
                
                 selectInput(inputId = "Cultivo",
                             label = h6("Cultivo:"), choices = levels(MxMunicipios1$Cultivo),
                             selected = "Agave"),
                 
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
                 column(9,leafletOutput("mymap", width = "1300", height = "1000"))
               )
               #leafletOutput("mymap", width = "100%", height = "100%")
             )
           )) 
  ),
  
  tabPanel('Diversidad',
           #div(img(src = "CONABIO_LOGO_13.JPG", width = "250", height = "250"), style = "text-align: center;"),
           #br(),
           bootstrapPage( 
             
             h4("Para evaluar la eficacia  de los muestreos se realizaran curvas de rarefracción, que
                nos ayudan a ver la eficacia del muestreo y la comparabilidad de los sitios de estudio o
                sistemas. Al mismo tiempo nos da una riqueza de especies.
                Los análisis estan basados en la formulación de Hulbert’s (1971) y 
                un error estándar de Heck et al. (1975)."),
             br(),
             br(),
             sidebarLayout(
               sidebarPanel(
                 
                 #selectInput(inputId = "Columna", label = h4("Variables"),
                  #           choices = names(TableL4)[2:4], selected = names(TableL4)[2], multiple = F),
                 
                 br()
                 
                 # selectInput(inputId = "Complejo_racials",
                 #             label = h6("Grupo racial:"),
                 #             levels(TableLL$Complejo_racial)),
                 
                 
                 
                 , width = 0),  
               fluidRow(column(8,
                               plotOutput("Rarefraction", width = "1300", height = "1000"))
               )
               
               
             )
             
             
             ),
           br(),
           br(),
           br(),
           br(),
           br(),
           
           h4(" Las curvas de diversidad de Renyi son líneas que 
              dan información de riqueza, equidad y permite comparar entre 
              distintos sitios o parcelas de forma gráfica, ordenando de 
              mayor a menor, lo que facilita su interpretación 
              (Kindt y Coe, 2005). Si una curva esta por encima de otra, 
              significa que tiene un mayor “perfil” con respecto a la 
              diversidad. Si las curvas se cruzan entre si, nos indica que 
              no es posible comparar esos dos ecosistemas en particular 
              (Kindt y Coe, 2005; Tóthmérész, 1995). El valor en el eje de las 'x' igual a 0, 1 y 2, 
              representan la riqueza, diversidad de shannon y simpson respectivamente; para obtener 
              En diversidad Rényi las curvas represetan: Riqueza (exp(x=0)), diversidad Shannon (x=1), 
              Inversa de simpson (exp (x=2)). Finalmente, la pendiente o la forma de la curva nos dice la equidad"),
           br(),
           fluidRow(column(9,
                           plotlyOutput("Renyi1", width = "1000", height = "600"))
           )
           
           
           )  
))

