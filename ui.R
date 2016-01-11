library(shiny)
#NK repertoire stability data visualization app
stability <- read.table("StabilityData",header=TRUE,colClasses=c(rep("factor",4),"numeric","factor"))
dataset <- stability

#Define UI
shinyUI(fluidPage(
  
  title = "Human NK Cell Repertoire Stability",
  
  plotOutput('plot',width = "900px",height="600px"),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Human NK Cell Repertoire Stability"),
           
           br(),
           checkboxInput('jitter', 'Jitter'),
           checkboxInput('smooth', 'Smooth')
    ),
    column(4, offset = 1,
           selectInput('x', 'X', names(dataset),selected="Timepoint"),
           selectInput('y', 'Y', names(dataset), selected="Marker"),
           selectInput('facet_row', 'Facet Row',c(None='.', names(stability[sapply(stability, is.factor)]))),
           selectInput('facet_col', 'Facet Column',c(None='.', names(stability[sapply(stability, is.factor)])),selected="Donor")
    ),
    column(4,
           selectInput('color', 'Color', c('None', names(dataset)),selected="Type"),
           selectInput('size', 'Size', c('None', names(dataset)),selected="Frequency")
    )
  )
))