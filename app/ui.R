#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shinydashboard)
library(DT)
library(shiny)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(bs4Dash)
library(dplyr)
library(plotly)
library(tidyverse)
library(rvest)
library(RPostgres)


#=========================== Interface (Front-End) ============================#

fluidPage(skin = "yellow",dashboardPage(
  
  dashboardHeader(title="WELCOME TO", titleWidth = 300, status ="warning"),
  #------------SIDEBAR-----------------#
  dashboardSidebar(width = 300, skin = "blue",
                   sidebarMenu(
                     tags$div( 
                       img(src = "Logo.png", height = 115, width = 230)
                     ),
                     menuItem("Beranda", tabName = "beranda", icon = icon("home")),
                     menuItem("Cari", tabName = "browse", icon = icon("search")),
                     menuItem("Review Film", tabName = "reviewfilm", icon = icon("comment")),
                     menuItem("Daftar Film", tabName = "daftar_film", icon = icon("edit")),
                     menuItem("Statistik", tabName = "statistik", icon = icon("chart-column")),
                     menuItem("Tentang", tabName = "tentang", icon = icon("info"))
                   ), HTML(paste0(
                     "<br><br><br><br><br><br><br><br><br>",
                     "<table style='margin-left:auto; margin-right:auto;'>",
                     "<tr>",
                     "<td style='padding: 5px;'><a href='https://www.facebook.com/imdb' target='_blank'><i class='fab fa-facebook-square fa-lg'></i></a></td>",
                     "<td style='padding: 5px;'><a href='https://www.youtube.com/@imdb' target='_blank'><i class='fab fa-youtube fa-lg'></i></a></td>",
                     "<td style='padding: 5px;'><a href='https://www.twitter.com/IMDb' target='_blank'><i class='fab fa-twitter fa-lg'></i></a></td>",
                     "<td style='padding: 5px;'><a href='https://www.instagram.com/imdb' target='_blank'><i class='fab fa-instagram fa-lg'></i></a></td>",
                     "</tr>",
                     "</table>",
                     "<br>"
                   ))
                   
  ),
  #-----------------BODY-----------------#
  dashboardBody(
#-------------------------Tab Beranda-------------------------#
    tabItems(
      tabItem(tabName = "beranda",
              jumbotron(
                title = div(
                  img(src = "Logo.png", height =400, width = 800), style = "text-align: center;"),
                lead = "Mau Nonton Film Apa Nih?",
                href = "https://www.imdb.com/",
                status = "warning",
                span("Galau mau nonton film apa karena takut filmnya gak sesuai ekspektasi? udah tenang aja, INMOVIE jawabannya! Semua informasi penting tentang karya sinematik Indonesia sudah terangkum di sini. Butuh informasi tentang aktor, sutradara, atau bahkan ulasan? Ada! it's time to dive into films!
Apa itu INMOVIE? INMOVIE adalah database film Indonesia Database sistem yang diciptakan untuk merinci dan mengorganisir informasi terkait film, seperti daftar pemeran, sutradara, tanggal rilis, genre, dan lebih banyak lagi. Ini adalah perpustakaan digital yang menyediakan akses cepat dan efisien ke seluruh spektrum film.",
                     style = "font-size:20px;text-align:justify;")),
              tags$h2("Apa saja yang ditemui dalam INMOVIE?"),
              tags$p(),
              tags$ol(
                tags$li("Informasi Film"),
                tags$p("Data utama tentang judul film, aktor dan sutradara."),
                tags$br(),
                tags$li("Ulasan dan Peringkat"),
                tags$p("Komentar dan penilaian dari reviewer."),
                tags$br(),
                tags$li("Genre"),
                tags$p("Kategori atau jenis film yang dapat membantu penonton memilih sesuai selera."),
                tags$br(),
                tags$li("Film Terbaik"),
                tags$p("Film terbaik berdasarkan genre, tahun rilis, rating ataupun secara keseluruhan.")
              )
      ),
#-------------------------Tab Cari-------------------------#
      tabItem(
        tabName = "browse",
        fluidRow(
          tags$h1("Cari Film Sesuai Preferensimu")
        ),
        fluidRow(
          # Filter tahun rilis film
          box(background = "primary",
            tags$h3("Tahun Rilis"),
            tags$p("Mau nonton film tahun berapa?"),
            tags$br(),
            uiOutput("filter_1"),
            width = 3
          ),
          # Filter rating film
          box(background = "primary",
            tags$h3("Rating Film"),
            tags$p("Rating mungkin penting untuk kamu pertimbangkan"),
            tags$br(),
            uiOutput("filter_2"),
            width = 3
          ),
          # Filter genre film
          box(background = "primary",
            tags$h3("Genre Film"),
            tags$p("Kamu suka film genre apa?"),
            tags$br(),
            uiOutput("filter_3"),
            width = 3
          ),
          # Filter sutradara
          box(background = "primary",
            tags$h3("Sutradara"),
            tags$p("Mau siapa yang ngedirect filmnya?"),
            tags$br(),
            uiOutput("filter_5"),
            width = 3
          )
          ),
        fluidRow(
          # Display tabel 
          box(background = "warning",
            tags$h3("Tabel"),
            dataTableOutput("out_tbl1"),
            width = 12
          )
        )
      ),
    
#-------------------------Tab Review Film-------------------------#
tabItem(
  tabName = "reviewfilm",
  fluidRow(
    tags$h1("Mau Liat Review Film Apa?")
  ),
  fluidRow(
    # Filter judul Film
    box(background = "primary",
      tags$h3("Judul Film"),
      tags$p("Cek judul Film di tab cari"),
      tags$br(),
      uiOutput("filter_6"),
      width = 3
    )
  ),
  fluidRow(
    # Display tabel 
    box(background = "warning",
      tags$h3("Tabel Review Film"),
      dataTableOutput("out_tbl2"),
      width = 12
    )
  )
),

#--------------------------Tab Daftar Film--------------------------#
    tabItem(
      tabName = "daftar_film",
      fluidRow(
        tags$h1("Daftar Film pada Inmovie Indonesia Database", style = "text-align: center; font-weight: bold;")
      ),
      fluidRow(
        style = "display: flex; justify-content: center; align-items: center;",
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMjViNTVhY2QtZjE1OS00OWIyLTkyM2EtNmYwOTA0ZTdkZDRmXkEyXkFqcGdeQXVyNzEzNjU1NDg@.V1_FMjpg_UX1000.jpg", height = 150, width = 100),
               h6("agak laen", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt28856462/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://suarabuana.com/wp-content/uploads/2023/09/IMG-20230907-WA0000-861x1024.jpg", height = 150, width = 100),
               h6("Sleep Call", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt26489336/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BYjU5NjYyNzQtZDQ3Ny00Y2FkLWIyZGYtNzM5YzM3NDdjMjUxXkEyXkFqcGdeQXVyMzYzOTYxNzM@.V1_UY209_CR1,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Satan's Slaves", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt7076834/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNmY5YWI2OTQtYWU1MC00MDk1LWJkYzQtNTU1YTM3YjdhY2E3XkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_QL75_UY148_CR1,0,100,148.jpg", height = 150, width = 100),
               h6("Photocopier", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt13729220/?ref_=nv_sr_srsg_0_tt_8_nm_0_q_Photocopier", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BM2E3MjQyOWQtZjFhNC00NDYxLWIxYmUtN2NiZjg0YmJhYTJkXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_QL75_UX100_CR0,1,100,148.jpg", height = 150, width = 100),
               h6("Missing Home", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt16266336/?ref_=nv_sr_srsg_0_tt_8_nm_0_q_Missing%2520Home", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BZTc3MDY4YWItZjJlZS00N2YyLThiZjAtOWI0OWRjY2VkNWRmXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_QL75_UX100_CR0,1,100,148.jpg", height = 150, width = 100),
               h6("Falling in Love Like in Movies", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt26903085/?ref_=nv_sr_srsg_0_tt_8_nm_0_q_Falling%2520in%2520Love%2520Like%2520in%2520Movies", style = "text-align: center; display:block;", "trailer")
        )
      ),
      tags$br(),
      fluidRow(
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMWY1YjUyYzMtMDU5My00NmQ3LThlM2YtMDFhMjgyZGEwMWIxXkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_QL75_UX100_CR0,1,100,148.jpg", height = 150, width = 100),
               h6("Sri Asih", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt10994712/?ref_=nv_sr_srsg_0_tt_2_nm_6_q_Sri%2520Asih", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMjU2NGQzMDQtMmM2My00MmFmLTgzY2EtZmFkNWY1N2EyYjA0XkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_QL75_UY148_CR0,0,100,148.jpg", height = 150, width = 100),
               h6("Miracle in Cell No. 7", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt11799822/?ref_=nv_sr_srsg_4_tt_8_nm_0_q_Miracle%2520in%2520Cell%2520No.%25207", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNWZmOTIzOGMtODBmMC00MjVlLThjYzUtNjcxNjg4NzY0YTg1XkEyXkFqcGdeQXVyNzEzNjU1NDg@.V1_QL75_UY148_CR9,0,100,148.jpg", height = 150, width = 100),
               h6("	Stealing Raden Saleh", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt13484872/?ref_=nv_sr_srsg_0_tt_1_nm_0_q_%2509Stealing%2520Raden%2520Saleh", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNThhYWRmNGQtYjJiMC00YWRhLWI0ZWUtY2VmMWFjNGM2NjUzXkEyXkFqcGdeQXVyNzkzODk2Mzc@.V1_QL75_UY148_CR9,0,100,148.jpg", height = 150, width = 100),
               h6("Two Blue Stripes", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt10495746/?ref_=nv_sr_srsg_0_tt_2_nm_0_q_Two%2520Blue%2520Stripes", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BN2QwMzIxN2UtMWVlNS00NjJmLWI4ZTMtM2U4NTdhZTRiMDE1XkEyXkFqcGdeQXVyNjYxNDc5MzU@.V1_QL75_UY148_CR2,0,100,148.jpg", height = 150, width = 100),
               h6("Whats Up with Cinta?", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt0307920/?ref_=nv_sr_srsg_0_tt_2_nm_0_q_Whats%2520Up%2520with%2520Cinta%253F", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BYTY3OGU2OWUtMWRjZi00MDBiLTliODMtNjI4NGMzOWE5ZmZlXkEyXkFqcGdeQXVyNzEzNjU1NDg@.V1_QL75_UY148_CR9,0,100,148.jpg", height = 150, width = 100),
               h6("Ganjil Genap", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt23807292/?ref_=nv_sr_srsg_0_tt_1_nm_1_q_Ganjil%2520Genap", style = "text-align: center; display:block;", "trailer")
        )
      ),
      tags$br(),
      fluidRow(
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BZDJiMzExYWItYmZkMC00YmU5LWJlYjEtODQyNDRmZWQ3YTIyXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_QL75_UY148_CR1,0,100,148.jpg", height = 150, width = 100),
               h6("Broken Wings", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt18938680/?ref_=nv_sr_srsg_0_tt_8_nm_0_q_Broken%2520Wings", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BYmMzMTZjODEtYWQyYi00MGZmLTg4NTUtYjJkMjRiMTI4MDViXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_QL75_UY148_CR9,0,100,148.jpg", height = 150, width = 100),
               h6("Yuni", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt13834788/?ref_=nv_sr_srsg_0_tt_1_nm_7_q_Yuni", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNGVlZDcxZjgtZTY4Ny00OGZhLThmMGYtMGIwMmY5M2QwOWIyXkEyXkFqcGdeQXVyNzEzNjU1NDg@.V1_UY209_CR13,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Imperfect", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt10932100/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BYzM3N2I1MGUtZWQwOS00ZGM3LThmYzQtN2NmMWZjYWJlZGVhXkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_UY209_CR13,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Cemaras Family", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt7885874/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BODQzMWY2NWUtMzZkMS00ODllLWEwNWYtMTE3NDRlZDQ1ZWRlXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_UY209_CR13,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Perfect Strangers", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt17497250/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMDFlZDhjMDctODI4Yy00NjZkLWJkNWYtNGExNWVkZDA1MGNiL2ltYWdlXkEyXkFqcGdeQXVyMzUwMTk4OTI@.V1_UY209_CR13,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Cek Toko Sebelah", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt6366854/?ref_=nv_sr_srsg_0_tt_6_nm_0_q_Check%2520Store%2520Next%2520Door", style = "text-align: center; display:block;", "trailer")
        )
      ),
      tags$br(),
      fluidRow(
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMzRkY2FhZDEtZmI4Ny00NTU5LWEzMzktNDM5NTY5MTQ5ZmZmXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Cek Toko Sebelah 2", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt21619378/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMThkMTJlMDItMjg1OS00OWFkLWEzMDEtOGRlNzc5YTgwNmViXkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Cinta Pertama; Kedua; & Ketiga", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt12741494/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
               
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNmNkY2JiMWQtMDBhYy00YmQ3LTkwMTItZWY5NzJkZTQ2MThhXkEyXkFqcGdeQXVyNjU3MTA2OTQ@.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("5 cm", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt2713324/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMzk1YzRkNmMtMTEzMC00MzhiLThhMWQtNzE2YzgzYWVmYzZhXkEyXkFqcGdeQXVyNjIwMTgzMTg@.V1_UY209_CR3,0,140,209_AL.jpg", height = 150, width = 100),
               h6("My Stupid Boss 2", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt5514296/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BM2Q0NmNjM2UtZThlZi00MmZlLTg1ZTUtMTJlM2M5MGU1ZjgwXkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_UY209_CR1,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Fireworks", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt26687781/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BYjg4YTdhYWMtMTIxZC00OGZmLWJjNjgtZmViOThkNmVjMTk4XkEyXkFqcGdeQXVyMzY3MDU4NDk@.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Whats Up with Cinta 2", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt5687416/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        )
      ),
      tags$br(),
      fluidRow(
        
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMTBhNDY5NTItMGNlNS00YWFkLTg3NDMtNDZkZTE0ZGExNzUzXkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("aruna & parlate", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt8894180/?ref_=nv_sr_srsg_7_tt_2_nm_6_q_aruna", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNTA1YzI5MTYtYjc5ZS00NzI2LTkwNTUtMGU0MjI3MzFkMDRiXkEyXkFqcGdeQXVyNzY4NDQzNTg@.V1_UX140_CR0,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Ghost Writer", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt10280220/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BNDg2MTExMDYtMzljMC00ZWRkLTgyMDktMWRmNzk3ZGVlYzI4XkEyXkFqcGdeQXVyNjc3MjQzNTI@.V1_UY209_CR8,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Gie", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt0459327/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMDQyZjdmZmYtZGViNC00ZGFkLWIxYjktNTI1YTc4YzJiMzM0XkEyXkFqcGdeQXVyMzA1NTc1NDk@.V1_UY209_CR1,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Habibie & Ainun", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt2589132/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        ),
        column(width = 2,
               style = "display: flex; flex-direction: column; align-items: center;",
               img(src = "https://m.media-amazon.com/images/M/MV5BMWRiN2RlOGYtYzAwZi00OTM1LTllZmYtM2ZmMzc3MjNiNmE1XkEyXkFqcGdeQXVyMTEzMTI1Mjk3.V1_UY209_CR13,0,140,209_AL.jpg", height = 150, width = 100),
               h6("Ghost Writer 2", style = "text-align: center;"),
               tags$a(href = "https://www.imdb.com/title/tt13409590/?ref_=ttls_li_tt", style = "text-align: center; display:block;", "trailer")
        )
      )
    ),
            

#-------------------------Tab Statistik-------------------------#
tabItem(
  tabName = "statistik",
  tabsetPanel(
    type = "tabs",
    tabPanel(
      title = "votes",
      fluidRow(
        tags$h2("10 film dengan votes terbanyak pada Inmovie Indonesia", style = "text-align: center; font-weight: bold;"),
        tags$br()
      ),
      fluidRow(
        box(background = "warning",
          tags$h4("Votes Film"),
          tags$p("Peringkat diurutkan berdasarkan votes film dari seluruh penonton dalam database", style = "text-align: center; font-weight: bold;"),
          tableOutput("out_tbl3"),
          width = 6
        )
      )
    ),
    tabPanel(
      title = "rating",
      fluidRow(
        tags$br(),
        tags$ h2("10 film rating tertinggi pada iInmovie", style = "text-align: center; font-weight: bold;"),
        tags$br(),
      ),
      fluidRow(
        box(background = "warning",
          h4("Rating Film"),
          p("Peringkat diurutkan berdasarkan rating film yang telah diulang dari masing-masing penonton dalam database", style = "text-align: center; font-weight: bold;"),
          tableOutput("out_tbl4"),
          width = 6
        )
      )
    )
  )
),
      
      #-------------------------Tab Tentang-------------------------#
      tabItem(tabName = "tentang",
              tags$h2("Info Pengembang Situs"),
              fluidRow(
                box(background = "warning",
                  tags$h3("Kami Di Balik INMOVIES"),
                  tags$br(),
                  div(
                    img(src = "MDS5.png", height =500, width = 888), style = "text-align: center;"),
                  tags$br(),
                  width = 12
                  )),
              tags$p("Situs ini merupakan projek praktikum kelompok 5 mata kuliah Manajemen Data Statistika (STA1582) dari Program Statistika dan Sains Data Pascasarjana IPB University.
                 Tim pengembang situs adalah sebagai berikut,"),
              tags$ul(
                tags$li("(G1501231013) Dwi Fitrianti sebagai Database Manager"),
                tags$li("(G1501231039) Reza Arianti sebagai Technical Writer"),
                tags$li("(G1501231088) Eka Dicky Darmawan Yanuari sebagai Front-end Shiny Developer"),
                tags$li("(G1501231060) Siti Hafsah sebagai Back-end Shiny Developer")
              ),
              tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
              tags$a(href="https://github.com/sitihafsah12/kelompok5_MDS", "link github"))
    )
  ))
,     #-----------------FOOTER-----------------#
dashboardFooter(
  left = "© 2024 MDS Kelompok 5"
))
