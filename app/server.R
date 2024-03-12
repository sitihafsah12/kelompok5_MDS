#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)
library(tidyverse)
library(rvest)


#=========================== Connect Database ============================#
  
    connectDB <- function(){
    driver <- dbDriver('PostgreSQL')
    # Set connection details
    db <- dbConnect(
      driver,
      dbname = "lzcyuguv",
      host = "topsy.db.elephantsql.com",
      user = "lzcyuguv",
      password = "klDSz8KVu4hTnXJHJhjsGgiisvH791kU"
    )
    return(db)
  }
    
    #-----------------------------------------------------------------------------#
    # Query 2: Tabel reviews
    q2 <- print(
      "SELECT f.judul_film, u.nama_user, u.isi_user, u.tanggal_user, u.rating_user
FROM film f
JOIN reviews u ON f.id_film = u.id_film")
    
    
    #-----------------------------------------------------------------------------#
    # Query 3: Leaderboard film berdasarkan Banyaknya votes
    q3 <- print(
      "SELECT id_film, judul_film, votes
  FROM film
  ORDER BY votes DESC
  LIMIT 10")
    # Query 4: Leaderboard film berdasarkan Banyaknya rating
    q4 <- print("SELECT id_film, judul_film, rating
            FROM film
            ORDER BY rating DESC
            LIMIT 10")
    
    
    #--------------------------Pembentukan Dataframe-------------------------------#
    # Ubah dataset yang ditarik dari database menjadi bentuk Dataframe
    DB <- connectDB()
    tabel02 <- data.frame(dbGetQuery(DB, q2))
    tabel03 <- data.frame(dbGetQuery(DB, q3))
    tabel04 <- data.frame(dbGetQuery(DB, q4))
    dbDisconnect(DB)
    
function(input, output, session) {
  # Helper function untuk membangun query berdasarkan filter
  generateQuery <- function(){
    conditions <- list()
    
    if (!is.null(input$in_tahun) && length(input$in_tahun) == 2) {
      conditions <- c(conditions, sprintf("tahun_rilis BETWEEN %d AND %d", input$in_tahun[1], input$in_tahun[2]))
    }
    
    if (!is.null(input$in_rating) && length(input$in_rating) == 2) {
      conditions <- c(conditions, sprintf("CAST(rating AS decimal) BETWEEN %d AND %d", input$in_rating[1], input$in_rating[2]))
    }
    
    if (input$in_genre != '' && input$in_genre != 'All') {
      conditions <- c(conditions, sprintf("genre_film = '%s'", input$in_genre))
    }
    
    # Subquery untuk sutradara
    if (input$in_sutradara != '' && input$in_sutradara != 'All') {
      conditions <- c(conditions, sprintf("EXISTS (SELECT 1 FROM public.sutradara s WHERE s.id_film = film.id_film AND s.nama_sutradara = '%s')", input$in_sutradara))
    }
    
    query <- "SELECT judul_film, durasi_film, COALESCE(votes,0) AS votes, a.nama_aktor FROM public.film f JOIN public.aktor a ON f.id_film = a.id_film"
    if (length(conditions) > 0) {
      query <- sprintf("%s WHERE %s", query, paste(conditions, collapse = " AND "))
    }
    
    return(query)
  }
  
  # Menampilkan tabel film yang telah disaring atau semua film pada tampilan awal
  output$out_tbl1 <- renderDataTable({
    db <- connectDB()
    query <- generateQuery()
    movies <- dbGetQuery(db, query)
    dbDisconnect(db)
    datatable(movies, options = list(pageLength = 10, autoWidth = TRUE))
  })

#-------------------------Tab Cari-------------------------#  
    
  # Slider untuk tahun rilis
  output$filter_1 <- renderUI({
    sliderInput("in_tahun", "Tahun Rilis", min = 2000, max = 2024, value = c(2000, 2024))
  })
  
  # Slider untuk rating
  output$filter_2 <- renderUI({
    sliderInput("in_rating", "Rating Film", min = 1, max = 10, value = c(1, 10))
  })
  
  # Dropdown untuk genre
  output$filter_3 <- renderUI({
    db <- connectDB()
    genres <- dbGetQuery(db, "SELECT DISTINCT genre_film FROM public.film ORDER BY genre_film")
    dbDisconnect(db)
    selectInput("in_genre", "Genre Film", choices = c('All' = 'All', setNames(genres$genre_film, genres$genre_film)), multiple = FALSE)
  })
  
  # Dropdown untuk sutradara
  output$filter_5 <- renderUI({
    db <- connectDB()
    directors <- dbGetQuery(db, "SELECT DISTINCT nama_sutradara FROM public.sutradara ORDER BY nama_sutradara")
    dbDisconnect(db)
    selectInput("in_sutradara", "Sutradara", choices = c('All' = 'All', setNames(directors$nama_sutradara, directors$nama_sutradara)), multiple = FALSE)
  })
  
  # Ketika filter berubah, update tabel
  observe({
    output$out_tbl1 <- renderDataTable({
      db <- connectDB()
      query <- generateQuery()
      movies <- dbGetQuery(db, query)
      dbDisconnect(db)
      datatable(movies, options = list(pageLength = 10, autoWidth = TRUE))
    })
  })
  
#-------------------------Tab Review Film-------------------------#

  # Filter Genre Film
  output$filter_6 <- renderUI({
    selectInput(
      inputId = "in_review",
      label = "Masukkan judul Film",
      multiple = TRUE,
      choices = sort(as.character(tabel02$judul_film))
    )
  })
  # Definisi Data
  data2 <- reactive({
    tabel02 %>% filter(judul_film %in% input$in_review)
  })
  # Render Tabel Data
  output$out_tbl2 <- renderDataTable({
    data2()
  })
  
  #----------------------Tab Statistik-------------------------#
  # Render Tabel Data Leaderboard (Film berdasar votes)
  output$out_tbl3 <- renderTable(tabel03)
  # Render Tabel Data Leaderboard (Film berdasar rating)
  output$out_tbl4 <- renderTable(tabel04)
  
#-------------------------Tab Tentang-------------------------#

}