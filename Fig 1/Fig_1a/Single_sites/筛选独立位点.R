library(dplyr)
library(tidyverse)
library(readxl)
library(openxlsx)
library(magrittr)
library(gtools)

###输出不同处理组的所有修饰情况 不同处理组的蛋白和位点总数 不同处理组不同修饰组的蛋白和位点

##所有质谱文件形成List

PTMnames <- c('Ac','Ub','Ma','Sc','Cr')

readpath_PTM <- 'E:/实验数据/Candida_auris/蛋白质谱原始数据/11762852单独/'

FinnalOriginal_List <- list()

savepath <- 'E:/实验数据/Candida_auris/蛋白质谱第七次分析（原始数据重新提供）/文件库/单一位点筛选/'

for (i in 1:5) {
  
  readpath <- paste(readpath_PTM,PTMnames[i],'.xlsx',sep = '')
  
  PTM <- read_excel(readpath,sheet = 3)
  
  colnames(PTM) <- PTM[1,]
  
  PTM <- PTM[-1,]
  
  PTM_Fiannal <- data.frame(PTM[,1:5],PTM[,42:53])
  
  FinnalOriginal_List <- c(FinnalOriginal_List,list(PTM_Fiannal))

}

#筛选每个样品各个修饰情况

sample_names <- c('F1176C','F1176F','F2852C','F2852F')

##统计蛋白个数和位点个数

proteinCounts_finnal <- matrix(nrow = length(sample_names), ncol = length(PTMnames))

colnames(proteinCounts_finnal) <- PTMnames

rownames(proteinCounts_finnal) <- sample_names

siteCounts_finnal <- matrix(nrow = length(sample_names), ncol = length(PTMnames))

colnames(siteCounts_finnal) <- PTMnames

rownames(siteCounts_finnal) <- sample_names

for (i in 1:length(sample_names)) {
  
  samplePTM <- paste(sample_names[i],1:3,sep = '_')
  
  Specific <- data.frame(Protein.accession = 'aaa',Position = 1,type = 'bbb')
  
  Specific <- Specific[-1,]
  
  proteinCounts <- c()##统计蛋白个数
  
  siteCounts <- c()##统计位点个数
  
  for (a in 1:length(PTMnames)) {
    
    PTMdata <- select(FinnalOriginal_List[[a]],Protein.accession,Position,all_of(samplePTM))
    
    PTMdata<-PTMdata[-which(apply(PTMdata,1,function(x) sum(is.na(x)) == 3)),]##去掉na=3的行
    
    PTMdata$type <- PTMnames[a]
    
    newdata <- select(PTMdata,Protein.accession,Position,type)
    
    Specific <- rbind(Specific,newdata)
    
    proteinCounts <- append(proteinCounts,length(unique(newdata[,1])))
    
    siteCounts <- append(siteCounts,nrow(newdata))
    
    ##输出newdata 为不同处理组不同修饰组的蛋白和位点情况
    
    savepath_newdata <- paste(savepath,sample_names[i],'_',PTMnames[a],'.csv',sep = '')
    
    write.csv(newdata,file = savepath_newdata)
    
  }
  
  ##统计蛋白位点个数
  
  proteinCounts_finnal[i,] <- proteinCounts
  
  siteCounts_finnal[i,] <- siteCounts
  
  ##单一位点筛选
  
  Specific$Specific_site <- paste(Specific$Protein.accession,Specific$Position,sep = '_')
  
  unique <- as.matrix(unique(Specific[,4]))
  
  unique_final <- matrix(nrow = length(unique), ncol = 7)
  
  unique_final[,1] <- unique[,1]
  
  for (b in 1:length(unique)) {
    
    nk <- filter(Specific,Specific_site == unique[b])
    
    MultiPTM <- paste(nk[1:length(nk$type),3],sep = ',')
    
    unique_final[which(unique_final == nk[1,4]),2:c(1+length(MultiPTM))] <- MultiPTM
    
  }
  
  savepath_PTM <- paste(savepath,sample_names[i],'.csv',sep = '')
  
  write.csv(unique_final, file = savepath_PTM)
  
}

savepath_proteinCounts <- paste(savepath,'proteinCounts','.csv',sep = '')

savepath_siteCounts <- paste(savepath,'siteCounts','.csv',sep = '')

write.csv(proteinCounts_finnal, file = savepath_proteinCounts)

write.csv(siteCounts_finnal, file = savepath_siteCounts)




