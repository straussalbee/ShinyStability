# server.R

library(ggplot2)
stability <- read.table("StabilityData",header=TRUE,colClasses=c(rep("factor",4),"numeric","factor"))
stability$Donor <- factor(stability$Donor,ordered=TRUE,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))

shinyServer(function(input, output) {
  
  dataset <- reactive(stability)
  
  output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    if (input$size != 'None')
      p <- p + aes_string(size=input$size)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  })
  
})