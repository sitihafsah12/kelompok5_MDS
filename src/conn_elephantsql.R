library(RPostgreSQL)
library(DBI)
driver <- dbDriver('PostgreSQL')
DB <- dbConnect(
  driver,
  dbname="lzcyuguv", # User & Default database
  host="topsy.db.elephantsql.com", # Server
  # port=5433,
  user="lzcyuguv", # User & Default database
  password="klDSz8KVu4hTnXJHJhjsGgiisvH791kU" # Password
)

dbhost<-dbConnect(
  driver, 
  dbname="film_indo", 
  host="localhost",
  port=5432,
  user="postgres",
  password="1234567"
)

# select departemen dari table departemen
fil=dbReadTable(dbhost,'film')
sut=dbReadTable(dbhost,'sutradara')
akt=dbReadTable(dbhost,'aktor')
rev=dbReadTable(dbhost,'reviews')
dbWriteTable(DB,'film',fil,overwrite=T,row.names=F)
dbWriteTable(DB,'sutradara',sut,overwrite=T,row.names=F)
dbWriteTable(DB,'aktor',akt,overwrite=T,row.names=F)
dbWriteTable(DB,'reviews',rev,overwrite=T,row.names=F)