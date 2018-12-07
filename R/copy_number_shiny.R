#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#' start copy-number/survival shiny app
#'
#' @import shiny
#' @importFrom survival coxph Surv
#'
#' @export
target_shiny_copy_number_survival = function() {

  cn_se = target_gistic_se()

  metastatic = !is.na(colData(cn_se)$`Metastasis site`)

  os_obj = Surv(time = colData(cn_se)$`Time to First Event in Days`,
                event = colData(cn_se)$`Vital Status`=='Dead')
  rfs_obj = Surv(time = colData(cn_se)$`Time to First Event in Days`,
                 event = !is.na(colData(cn_se)$`Time to first relapse in days`))



  # Define UI for application that draws a histogram
  ui <- fluidPage(

    # Application title
    titlePanel("Copy Number Survival Analysis"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        selectizeInput('gene', 'gene', rowData(cn_se)$`Gene Symbol`, selected = "MYC", multiple = FALSE,
                       options = NULL),
        selectInput('survival', 'Survival Outcome', c('overall','relapse-free'), selected='overall')
      ),

      # Show a plot of the generated distribution
      mainPanel(
        textOutput('title'),
        verbatimTextOutput('text')
      )
    )
  )

  # Define server logic required to draw a histogram
  server <- function(input, output) {
    res = reactive({
      if(!(input$gene %in% rowData(cn_se)$`Gene Symbol`)) return(NULL)
      cn = assay(cn_se, 'cn')[rowData(cn_se)$`Gene Symbol` == input$gene,]
      if(input$survival=='overall')
        res = coxph(os_obj ~ cn + metastatic)
      else
        res = coxph(rfs_obj ~ cn + metastatic)
      res
    })
    output$text = renderPrint({
      res()
    })
    output$title = renderText({
      sprintf('%s survival, %s', input$survival, input$gene)
    })
  }

  # Run the application
  shinyApp(ui = ui, server = server)
}
