# 3 for midterm
# Project B: Album Ratings
library(RCurl)
library(selectr)
library(xml2)
library(rvest)
library(XML)
library(stringr)
library(tidyverse)
u ="https://pitchfork.com/reviews/albums/grimes-miss-anthropocene/"

pitchfork = function(x){
  ur<-read_html(x)
  p<-html_text(ur)
  k<-gsub("<.*/>","",p)
  k<-gsub("[.]","",k)
  locationofrating<-str_locate(k,"display_rating.{9}")
  stringofrating<-str_sub(k,locationofrating[1],locationofrating[2])
  therating<-parse_number(stringofrating)
  if(therating>10){
    therating= therating/10
  }
  k<-str_replace_all(k,"\\{.*\\}","")
  j<-str_locate(k,"TwitterOpen share drawer")
  l<-str_locate(k,"\nBack to homewindowdigitalData")
  m<-str_sub(k,j[2]+1,l[1]-1)
  thereview<-str_replace_all(m,"\n"," ")
  theframe<-data.frame(text=thereview,rating=therating)
  theframe$text<-as.character(theframe$text)
  return(theframe)
}
review<-pitchfork(u)
