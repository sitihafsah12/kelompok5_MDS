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
            
             dashboardHeader(title="WELCOME TO", titleWidth = 300),
#------------SIDEBAR-----------------#
dashboardSidebar(width = 300,
                 sidebarMenu(
                   tags$div( 
                     img(src = "Logo.png", height = 115, width = 230)
                   ),
                   menuItem("Beranda", tabName = "beranda", icon = icon("home")),
                   menuItem("Cari", tabName = "browse", icon = icon("search")),
                   menuItem("Review Film", tabName = "reviewfilm", icon = icon("comment")),
                   menuItem("Tentang", tabName = "tentang", icon = icon("info")),
                 )
                 
),
#-----------------BODY-----------------#
dashboardBody(
#-------------------------Tab Beranda-------------------------#
tabItems(
  tabItem(tabName = "beranda",
          jumbotron(
            title = div(
              img(src = "Logo.png", height =575, width = 1150)),
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
    box(
      tags$h3("Tahun Rilis"),
      tags$p("Mau nonton film tahun berapa?"),
      tags$br(),
      uiOutput("filter_1"),
      width = 3
    ),
    # Filter rating film
    box(
      tags$h3("Rating Film"),
      tags$p("Rating mungkin penting untuk kamu pertimbangkan"),
      tags$br(),
      uiOutput("filter_2"),
      width = 3
    ),
    # Filter genre film
    box(
      tags$h3("Genre Film"),
      tags$p("Kamu suka film genre apa?"),
      tags$br(),
      uiOutput("filter_3"),
      width = 3
    ),
    # Filter aktor film
    box(
      tags$h3("Aktor"),
      tags$p("Lagi mau nonton film yang dibintangi siapa?"),
      tags$br(),
      uiOutput("filter_4"),
      width = 3
    ),
    # Filter sutradara
    box(
      tags$h3("Sutradara"),
      tags$p("Mau siapa yang ngedirect filmnya?"),
      tags$br(),
      uiOutput("filter_5"),
      width = 3
    )
  ),
  fluidRow(
    # Display tabel 
    box(
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
    # Filter ID Film
    box(
      tags$h3("ID Film"),
      tags$p("Cek ID Film di tab CARI"),
      tags$br(),
      uiOutput("filter_6"),
      width = 3
    )
  ),
  fluidRow(
    # Display tabel 
    box(
      tags$h3("Tabel Review Film"),
      dataTableOutput("out_tbl2"),
      width = 12
    )
  )
),

#-------------------------Tab Tentang-------------------------#
  tabItem(tabName = "tentang",
          tags$h2("Info Pengembang Situs"),
          tags$p("Situs ini merupakan projek praktikum kelompok 5 mata kuliah Manajemen Data Statistika (STA1582) dari Program Statistika dan Sains Data Pascasarjana IPB University.
                 Tim pengembang situs adalah sebagai berikut,"),
          tags$ul(
            tags$li("(G1501231088) Eka Dicky Darmawan Yanuari sebagai Database Manager"),
            tags$li("(G1501231060) Siti Hafsah sebagai Back-end Shiny Developer"),
            tags$li("(G1501231013) Dwi Fitrianti sebagai Front-end Shiny Developer"),
            tags$li("(G1501231039) Reza Arianti sebagai Technical Writer")
          ),
          tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
          tags$a(href="https://github.com/sitihafsah12/kelompok5_MDS", "link github"))
)
)
),     #-----------------FOOTER-----------------#
  dashboardFooter(
  left = "© 2024 MDS Kelompok 5"
))

