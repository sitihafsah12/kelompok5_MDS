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
    DB <- dbConnect(
      driver,
      dbname = "lzcyuguv",
      host = "topsy.db.elephantsql.com",
      user = "lzcyuguv",
      password = "klDSz8KVu4hTnXJHJhjsGgiisvH791kU"
    )
    return(DB)
  }
  
  con <- connectDB()
  
  
    film_query <- "SELECT id_film, id_sutradara, id_aktor, judul_film, tahun_rilis, durasi_film, genre_film, votes, rating FROM film"
    aktor_query <- "SELECT id_film, id_aktor, nama_aktor FROM aktor"
    reviews_query <- "SELECT id_user, id_film, nama_user, tanggal_user, isi_user, rating_user FROM reviews"
    sutradara_query <- "SELECT id_film, id_sutradara, nama_sutradara, tahun_rilis FROM sutradara"
    
    film_data <- dbGetQuery(con, film_query)
    aktor_data <- dbGetQuery(con, aktor_query)
    reviews_data <- dbGetQuery(con, reviews_query)
    sutradara_data <- dbGetQuery(con, sutradara_query)
    
    dbDisconnect(con)
  

function(input, output) {

#-------------------------Tab Cari-------------------------#  
    
  # Filter Tahun
  output$filter_1 <- renderUI({
    sliderInput(
      inputId = "in_tahun",
      label = "Pilih Tahun",
      min = 2010,
      max = 2024,
      step = 1,
      
      value = c(2017, 2020),
      sep = ''
    )
  })
  # Filter Rating
  output$filter_2 <- renderUI({
    sliderInput(
      inputId = "in_rating",
      label = "Rating Film",
      min = 1,
      max = 10,
      step = 1,
      
      value = c(4, 7),
      sep = ''
    )
  })
  # Filter Genre Film
  output$filter_3 <- renderUI({
    selectInput(
      inputId = "in_genre",
      label = "Pilih Genre Film",
      multiple = TRUE,
      choices = sort(as.character(film_data$genre_film))
    )
  })
  # Filter Aktor Film
  output$filter_4 <- renderUI({
    selectInput(
      inputId = "in_aktor",
      label = "Aktor",
      multiple = TRUE,
      choices = sort(as.character(aktor_data$nama_aktor))
    )
  })
  # Filter Sutradara Film
  output$filter_5 <- renderUI({
    selectInput(
      inputId = "in_sutradara",
      label = "Sutradara",
      multiple = TRUE,
      choices = sort(as.character(sutradara_data$nama_sutradara))
    )
  })
  # Definisi Data
  data1 <- reactive({
    film_data %>% filter(tahun_rilis >= input$in_tahun[1],
                       tahun_rilis <= input$in_tahun[2],
                       rating >= input$in_rating[1],
                       rating <= input$in_rating[2],
                       genre_film %in% input$in_genre)
    aktor_data %>% filter(nama_aktor %in% input$in_aktor)
    sutradara_data %>% filter(nama_sutradara %in% input$in_sutradara)
  })
  # Render Tabel Data
  output$out_tbl1 <- renderDataTable({
    data1()
  })
  
#-------------------------Tab Review Film-------------------------#

  # Filter Genre Film
  output$filter_6 <- renderUI({
    selectInput(
      inputId = "in_review",
      label = "Masukkan ID Film",
      multiple = TRUE,
      choices = sort(as.character(reviews_data$id_film))
    )
  })
  # Definisi Data
  data2 <- reactive({
    reviews_data %>% filter(id_film %in% input$in_review)
  })
  # Render Tabel Data
  output$out_tbl2 <- renderDataTable({
    data2()
  })
  
#-------------------------Tab Tentang-------------------------#

}