library(RPostgreSQL)
library(DBI)
driver <- dbDriver('PostgreSQL')
DB <- dbConnect(
  driver, 
  dbname="film_indo", 
  host="localhost",
  port=5432,
  user="postgres",
  password="1234567"
)

# Data film
data_film <- read.csv("https://raw.githubusercontent.com/sitihafsah12/kelompok5_MDS/main/Data/filmm.csv", sep = ",", fill = TRUE)
str(data_film)
data_film$votes <- as.integer(data_film$votes)
data_film$rating <- as.character(data_film$rating)

for (i in 1:nrow(data_film)) {
  # Replace empty strings with NULL or provide a default value
  id_sutradara <- ifelse(data_film[i, "id_sutradara"] == "", "NULL", data_film[i, "id_sutradara"])
  
  query <- paste0("INSERT INTO \"film\" (id_film, Id_sutradara, judul_film, tahun_rilis, durasi_film, genre_film, votes, rating) VALUES (",
                  "'", data_film[i, "id_film"], "', ",
                  id_sutradara, ", ",
                  "'", data_film[i, "judul_film"], "', ",
                  "'", data_film[i, "tahun_rilis"], "', ",
                  "'", data_film[i, "durasi_film"], "', ",
                  "'", data_film[i, "genre_film"], "', ",
                  "'", data_film[i, "votes"], "', ",
                  "'", data_film[i, "rating"], "');")
  
  query_execute <- DBI::dbGetQuery(conn = DB, statement = query)
}

## Melihat data dalam tabel
result <- dbGetQuery(DB, "SELECT * FROM \"film\"")
result

# Data aktor
data_aktor <- read.csv("https://raw.githubusercontent.com/sitihafsah12/kelompok5_MDS/main/Data/aktorr.csv", sep = ",", fill = TRUE)
str(data_aktor)
for (i in 1:nrow(data_aktor)) {
  # Check if Id_Aktor is not an empty string
  if (data_aktor[i, "Id_Aktor"] != "") {
    query <- paste0("INSERT INTO \"aktor\" (id_aktor, nama_aktor) VALUES (",
                    "'", data_aktor[i, "Id_Aktor"], "', ",
                    "'", data_aktor[i, "Nama.Aktor"], "');")
    query_execute <- DBI::dbGetQuery(conn = DB, statement = query)
  }
}

## Melihat data dalam tabel
result <- dbGetQuery(DB, "SELECT * FROM \"aktor\"")
result

# Data sutradara
data_sutradara <- read.csv("https://raw.githubusercontent.com/sitihafsah12/kelompok5_MDS/main/Data/sutradara.csv", sep = ",", fill = TRUE)
str(data_sutradara)
for (i in 1:nrow(data_sutradara)) {
  query <- paste0("INSERT INTO \"sutradara\" (id_film, id_sutradara, nama_sutradara, tahun_rilis) VALUES (",
                  "'", data_sutradara[i, "id_film"], "', ", 
                  "'", data_sutradara[i, "id_sutradara"], "', ",
                  "'", data_sutradara[i, "nama_sutradara"], "', ",
                  "'", data_sutradara[i, "tahun_rilis"], "');")
  query_execute <- DBI::dbGetQuery(conn = DB, statement = query)
}

## Melihat data dalam tabel
result <- dbGetQuery(DB, "SELECT * FROM \"sutradara\"")
result

# Data reviews
data_review<- read.csv("https://raw.githubusercontent.com/sitihafsah12/kelompok5_MDS/main/Data/reviews.csv", sep = ",", fill = TRUE)
str(data_review)
for (i in 1:nrow(data_review)) {
  # Truncate isi_user to a maximum of 100 characters
  isi_user_trimmed <- substr(data_review[i, "isi_user"], 1, 100)
  isi_user_trimmed <- gsub("'", "''", isi_user_trimmed)  # Escape single quotes
  
  # Construct the SQL query
  query <- paste0("INSERT INTO \"reviews\" (id_user, id_film, nama_user, tanggal_user, isi_user, rating_user) VALUES (",
                  "'", data_review[i, "id_user"], "', ", 
                  "'", data_review[i, "id_film"], "', ",
                  "'", data_review[i, "nama_user"], "', ",
                  "'", data_review[i, "tanggal_user"], "', ",
                  "'", isi_user_trimmed, "', ",
                  data_review[i, "rating_user"], ");")  # Removed single quotes for numeric value
  
  # Execute the query
  query_execute <- DBI::dbGetQuery(conn = DB, statement = query)
}
## Melihat data dalam tabel
result <- dbGetQuery(DB, "SELECT * FROM \"reviews\"")
result

# Data aktor_film
data_aktor_film <- read.csv("https://raw.githubusercontent.com/sitihafsah12/kelompok5_MDS/main/Data/aktor_film.csv", sep = ",", fill = TRUE)
str(data_aktor_film)
for (i in 1:nrow(data_aktor_film)) {
  query <- paste0("INSERT INTO \"aktor_film\" (id_aktor_film,id_film, id_aktor) VALUES (",
                  "'", data_aktor_film[i, "id_aktor_film"], "', ",
                  "'", data_aktor_film[i, "id_film"], "', ",
                  "'", data_aktor_film[i, "id_aktor"], "');")
  
  query_execute <- DBI::dbGetQuery(conn = DB, statement = query)
}
## Melihat data dalam tabel
result <- dbGetQuery(DB, "SELECT * FROM \"aktor_film\"")
result
