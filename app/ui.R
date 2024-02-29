#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinythemes)


fluidPage(theme = shinytheme("superhero"), dashboardPage(dashboardHeader(title = tags$img(src = "C:/Users/Eka Darmawan/Documents/KULIAH/S2 IPB - Statistika dan Sains Data/Semester 2/Responsi/Manajemen Data Statistika/Kelompok 5/MDS_Kel5/inmovies.png", height = 50)),
                                                         dashboardSidebar(
                                                           collapsed = TRUE,
                                                           sidebarMenu(
                                                             menuItem("Beranda", tabName = "beranda", icon = icon("home")),
                                                             menuItem("Film", tabName = "film", icon = icon("film")),
                                                             menuItem("Sutradara", tabName = "sutradara", icon = icon("user")),
                                                             menuItem("Aktor", tabName = "aktor", icon = icon("users")),
                                                             menuItem("Review", tabName = "review", icon = icon("comments")),
                                                             menuItem("Film Terbaik", tabName = "filmterbaik", icon = icon("star"))
                                                           )
                                                         ),
                                                         dashboardBody(shinyDashboardThemes(
                                                           theme = "grey_dark"
                                                         ),
                                                         tabItems(
                                                           tabItem(tabName = "beranda",
                                                                   jumbotron(
                                                                     title = tags$img(src = "C:/Users/Eka Darmawan/Documents/KULIAH/S2 IPB - Statistika dan Sains Data/Semester 2/Responsi/Manajemen Data Statistika/Kelompok 5/MDS_Kel5/inmovies.png", height = 50),
                                                                     lead = "Mau Nonton Film Apa Nih?", 
                                                                     span("Sering galau mau nonton film apa karena takut filmnya tidak sesuai ekspektasi? udahhh tenang aja, INMOVIE jawabannya! Semua informasi penting tentang karya sinematik Indonesia sudah terangkum di sini. Butuh informasi tentang aktor, sutradara, atau bahkan ulasan? Ada! it's time to dive into films!
Apa itu INMOVIE? INMOVIE adalah database film Indonesia Database sistem yang diciptakan untuk merinci dan mengorganisir informasi terkait film, seperti daftar pemeran, sutradara, tanggal rilis, genre, dan lebih banyak lagi. Ini adalah perpustakaan digital yang menyediakan akses cepat dan efisien ke seluruh spektrum film.",
                                                                          style = "font-size:20px;text-align:justify;")),
                                                                   tags$h2("Apa saja yang ditemui dalam INMOVIE?"),
                                                                   tags$ol(
                                                                     tags$li("Informasi Film"),
                                                                     tags$p("Data utama tentang judul film, aktor dan sutradara."),
                                                                     tags$br(),
                                                                     tags$li("Ulasan dan Peringkat"),
                                                                     tags$p("Komentar dan Penilaian dari Reviewer."),
                                                                     tags$br(),
                                                                     tags$li("Genre"),
                                                                     tags$p("Kategori atau jenis film yang dapat membantu penonton memilih sesuai selera."),
                                                                     tags$br(),
                                                                     tags$li("Film Terbaik"),
                                                                     tags$p("Film terbaik berdasarkan genre, tahun rilis, rating ataupun secara keseluruhan.")
                                                                   ),
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
                                                                   tags$a(href="https://github.com/sitihafsah12/kelompok5_MDS", "link github")
                                                           ),
                                                           tabItem(tabName = "film",
                                                                   fluidRow(
                                                                     box(plotOutput("plotFilm"), width = 6),
                                                                     box(tableOutput("tableFilm"), width = 6)
                                                                   )),
                                                           tabItem(tabName = "sutradara",
                                                                   fluidRow(
                                                                     box(plotOutput("plotSutradara"), width = 6),
                                                                     box(tableOutput("tableSutradara"), width = 6)
                                                                   )),
                                                           tabItem(tabName = "aktor",
                                                                   fluidRow(
                                                                     box(plotOutput("plotAktor"), width = 6),
                                                                     box(tableOutput("tableAktor"), width = 6)
                                                                   )),
                                                           tabItem(tabName = "review",
                                                                   fluidRow(
                                                                     box(plotOutput("plotReview"), width = 6),
                                                                     box(tableOutput("tableReview"), width = 6)
                                                                   )),
                                                           tabItem(tabName = "filmterbaik",
                                                                   fluidRow(
                                                                     box(plotOutput("plotFilmTerbaik"), width = 6),
                                                                     box(tableOutput("tableFilmTerbaik"), width = 6)
                                                                   ))
                                                         )
                                                         )
))