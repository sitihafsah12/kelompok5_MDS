#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {
  # Membuat plot dan tabel kosong untuk setiap tab
  output$plotBeranda <- renderPlot({})
  output$tableBeranda <- renderTable({})
  
  output$plotFilm <- renderPlot({})
  output$tableFilm <- renderTable({})
  
  output$plotSutradara <- renderPlot({})
  output$tableSutradara <- renderTable({})
  
  output$plotAktor <- renderPlot({})
  output$tableAktor <- renderTable({})
  
  output$plotReview <- renderPlot({})
  output$tableReview <- renderTable({})
  
  output$plotFilmTerbaik <- renderPlot({})
  output$tableFilmTerbaik <- renderTable({})
}