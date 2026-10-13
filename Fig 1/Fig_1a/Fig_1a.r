library(dplyr)
library(tidyverse)
library(readxl)
library(openxlsx)
library(magrittr)
library(gtools)
setwd('C:\\Users\\lihai\\Desktop\\Fig_1a')

savepath <- 'C:\\Users\\lihai\\Desktop\\Fig_1a'

##KEGG数据库

KOannotation <- read.delim("KOannotation.tsv", stringsAsFactors=FALSE)

KOannotation1 <- separate(KOannotation, col = 1, into =c('aaa','Gene','bbbb'), sep = "[|]", remove = FALSE)

KOannotation_final <- KOannotation1[,c(3,5,6:7)]

##KEGG分级数据库

KEGGlevel <- read.csv('KEGG_level.csv')[,c(2,5)]

colnames(KEGGlevel)[1] <- 'pathway'

BlevelFreq <- table(KEGGlevel$Blevel) %>% as.data.frame()

colnames(BlevelFreq) <- c('Blevel','BFreq')

##含有Blevel的库文件

BlevelinKO <- merge(KOannotation_final,KEGGlevel,by = 'pathway',all.x = T) %>% na.omit()

#各个Blevel含有的蛋白个数

BlevelProteinCounts <- table(BlevelinKO$Blevel) %>% as.data.frame()

colnames(BlevelProteinCounts) <- c('Blevel','proteinCounts')

##读取文件

path <- 'Single_sites'

pattern <- '\\w*_\\w*.csv'

fileNames <- dir(path = path,pattern = pattern)

sampleNames <- str_sub(fileNames,1,9)

filepath <- paste(path,'/',fileNames,sep = '')

fileList <- lapply(filepath, function(x){read.csv(x)})

sumData <- data.frame(Blevel = 'aaa',BlevelFreq = 0,proteinCounts = 0,Frequency = 0,type = 'aaa')

sumData <- sumData[-1,]

for (i in 1:length(fileList)) {
  
  sampleData <- fileList[[i]]
  
  uniqueProtein <- unique(sampleData$Protein.accession)
  
  KEGGnumb <- KOannotation_final[which(KOannotation_final$Gene %in% uniqueProtein),]
  
  colnames(KEGGnumb)[4] <- 'Clevel'
  ##存在部分库对不上的情况，将NA去除
  finnalData <- merge(KEGGnumb,KEGGlevel,by = 'pathway',all.x = T)
  
  finnalData <- na.omit(finnalData)
  
  #存在一个蛋白对应多个功能的情况，比如一个蛋白对应10个功能，那么每个功能出现的次数即为1
  
  finnalData$ClevelFreq <- 1
  
  #GeneCount <- table(finnalData$Gene) %>%as.data.frame()
  
  #计算每个Clevel在不同蛋白中的频数
  
  #for(a in 1:nrow(GeneCount)){
  
  #   finnalData[which(finnalData$Gene == GeneCount[a,1]),6] <- 1 / length(which(finnalData$Gene == GeneCount[a,1]))
  
  #}
  
  
  #计算在sampleDatad Clevel中属于不同Blevel的频数
  
  BlevelFinnalFreq <- data.frame(Blevel = unique(finnalData$Blevel),BlevelFreq = 0)
  
  for (a in 1:length(unique(finnalData$Blevel))) {
    
    BlevelFinnalFreq[a,2] <- sum(finnalData[which(finnalData$Blevel == BlevelFinnalFreq$Blevel[a]),6])
    
  }
  
  ##使用每个Blevel中含有的蛋白个数进行归一化
  
  FinnalFreq <- merge(BlevelFinnalFreq,BlevelProteinCounts,by = 'Blevel',all.x = T)
  
  FinnalFreq$Frequency <- FinnalFreq$BlevelFreq / FinnalFreq$proteinCounts
  
  #savepath_FinnalFreq <- paste(savepath,'/',sampleNames[i],'.csv',sep = '')
  
  #write.csv(FinnalFreq,file = savepath_FinnalFreq)
  
  FinnalFreq$type <- sampleNames[i]
  
  sumData <- rbind(sumData,FinnalFreq)
  
}



##根据修饰分面

library(ggsci)

factSumData <- sumData

factSumData <- separate(factSumData,col = 5,into = c('sampleType','PTMtype'),sep = '_',remove = F)

ggplot(data = factSumData, mapping = aes(x = Blevel, y = Frequency, group = sampleType,colour = sampleType)) + 
  geom_line() + geom_point()+
  theme_bw()+ 
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        panel.grid=element_blank())+   
  facet_grid(PTMtype~.,space="free")+ ##分面
  scale_color_npg()##ggsci设置配色

ggsave(filename = paste(savepath,'/BlevelPTMTotal.pdf',sep = ''),width=10,height=8,limitsize = FALSE)





