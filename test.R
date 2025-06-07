#############################年均資料##############################
library(dplyr)
library(lubridate)
setwd("C:/Users/admin/Desktop/碩/測站資料(四季均溫)")
var1<-list.files(pattern="*.csv", full.names=F)
site_name <- "十站"

for(i in 1:length(var1)){
  # i <- 16
  df<-read.csv(var1[i],sep=",",header=T)
  df.b<- df %>% 
    filter(時間 >= '19591201' & 時間 <= '20201131' )
  df.b$時間<- ymd(df.b$時間)
  x <- which(df.b$降水量.mm.<0)
  df.b$降水量.mm.[x] <- 0
#############################平均資料#############################
  if(i == 1 ){
    temp_all <- df.b$平均氣溫...
    rain_all <- df.b$降水量.mm.
  }else{
    temp_all <- temp_all + df.b$平均氣溫...
    rain_all <- rain_all + df.b$降水量.mm.
  }
}
date <- as.data.frame(ymd(df.b$時間))
temp_all <- as.data.frame(temp_all/10)
rain_all <- as.data.frame(rain_all/10)
all_year <- cbind(date,temp_all,rain_all)
all_year <- rename(all_year, c("Date"="ymd(df.b$時間)","MedTemp"="temp_all/10","MedRain"="rain_all/10"))
write.table(all_year,file="C:/Users/admin/Desktop/GRU_test/all_year.csv",sep=",",row.names = FALSE, na = "NA")
#############################平均資料(春)#############################
df.spring <- all_year %>%
  filter(between(month(Date),3 ,5))
write.table(df.spring,file="C:/Users/admin/Desktop/GRU_test/spring.csv",sep=",",row.names = FALSE, na = "NA")
#############################平均資料(夏)#############################
df.summer <- all_year %>%
  filter(between(month(Date),6 ,8))
write.table(df.summer,file="C:/Users/admin/Desktop/GRU_test/summer.csv",sep=",",row.names = FALSE, na = "NA")
#############################平均資料(秋)#############################
df.autumn <- all_year %>%
  filter(between(month(Date),9 ,11))
write.table(df.autumn,file="C:/Users/admin/Desktop/GRU_test/autumn.csv",sep=",",row.names = FALSE, na = "NA")
#############################平均資料(冬)#############################
df.winter1 <- all_year %>%
  filter(between(month(Date), 1,2))
df.winter2 <- all_year %>%
  filter(month(Date)==12)
df.winter12 <- rbind(df.winter1,df.winter2)
df.winter <- df.winter12 %>%
  arrange(df.winter12,desc(Date))
write.table(df.winter,file="C:/Users/admin/Desktop/GRU_test/winter.csv",sep=",",row.names = FALSE, na = "NA")


###############################測試################################
df <- 臺東
library(dplyr)
library(lubridate)
#########篩選##############
df.b<- df %>% 
  filter(時間 >= '19591201' & 時間 <= '20201131' )
df.b$時間<- ymd(df.b$時間)
#####################秋天#############################
df.spring <- df.b %>%
  filter(between(month(時間), 3,5))
df.b<- df %>% 
  filter(時間 >= '19600101' & 時間 <= '20201231' )
df.b$時間<- ymd(df.b$時間)
df.b <- df.b %>%
  filter(between(month(時間),3 ,4) & 平均氣溫... >=0)
#########P(總雨量)#########
a <- matrix(c(1960:2020), nrow=61, ncol=1)
a <- data.frame(a)
a <- rename(a, c("年"="a"))

group1 <- group_by(df.b,month = floor_date(時間,'month'))%>%
  summarise(天數=n(),Temp=sum(平均氣溫...)/n())
P<- rename(group1, c("時間"="month"))
if(i == 1 ){
  P_all <- P$降水量總和
}else{
  P_all <- P_all + P$降水量總和
}
