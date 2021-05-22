#install.packages('rvest')
#install.packages('xml2')
#install.packages('selectr')
#install.packages('stringr')
#install.packages('jsonlite')
library(rvest)
library(xml2)
library(selectr)
library(stringr)
library(jsonlite)
# the url
url ='https://www.nationmaster.com/country-info/stats/Geography/Geographic-coordinates'

#read HTML code 
page = read_html(url)

#scraping country name
name_page_html = html_nodes(page,'.full')

name_page= html_text(name_page_html)

head(name_page)

#scraping coordinates
coordinate_page_html= html_nodes(page,'td')

coordinate_page= html_text(coordinate_page_html)

head(coordinate_page)
#cleaning 
coordinate_page<-trimws(coordinate_page)
head(coordinate_page)

coordinates<-str_subset(coordinate_page,"\\d")
head(coordinates)
ok<-data.frame(countries= name_page,coor = coordinates)
