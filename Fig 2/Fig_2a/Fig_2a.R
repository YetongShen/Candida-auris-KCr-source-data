library(dplyr)
library(tidyverse)
library(readxl)
library(openxlsx)
library(magrittr)
library(stringr)
library(ggplot2)
library(tidyr)

savepath <- 'C:/Users/lihai/Desktop/Fig_2a/2C2F蛋白筛选'

path <- 'C:/Users/lihai/Desktop/Fig_2a/位点迁入迁出率'

pattern <- '\\w+vs\\w+.csv'

fileNames <- dir(path = path,pattern = pattern)[c(1,3)]

readpath <- sapply(fileNames,function(x) paste(path,'/',x,sep =''))

F2Cdata <- read.csv(readpath[1])

F2Fdata <- read.csv(readpath[2])

###筛选site

FilterSites_NATOCr <- function(dataFrame){
  
  sampleData <- dataFrame
  
  sampleData <- sampleData[-1,-1]
  
  filterData <- filter(sampleData,ID == 'NATOCr')
  
  return(as.data.frame(unique(filterData$site)))
  
}

F2C_sites <- FilterSites_NATOCr(F2Cdata)

write.csv(F2C_sites,file = paste(savepath,'/','F2C_sites.csv',sep = ''))

F2F_sites <- FilterSites_NATOCr(F2Fdata)

write.csv(F2F_sites,file = paste(savepath,'/','F2F_sites.csv',sep = ''))

###筛选protein

FilterProteins_NATOCr <- function(dataFrame){
  
  sampleData <- dataFrame
  
  sampleData <- sampleData[-1,-1]
  
  filterData <- filter(sampleData,ID == 'NATOCr')
  
  separateData <- separate(filterData, 3, into = c('ProteinID','Position'), sep = "_", remove = TRUE)
  
  proteinID <- unique(separateData$ProteinID)%>%as.data.frame()
  
  return(proteinID)
  
}

F2C_proteins <- FilterProteins_NATOCr(F2Cdata)

write.csv(F2C_proteins,file = paste(savepath,'/','F2C_proteins.csv',sep = ''))

F2F_proteins <- FilterProteins_NATOCr(F2Fdata)

write.csv(F2F_proteins,file = paste(savepath,'/','F2F_proteins.csv',sep = ''))