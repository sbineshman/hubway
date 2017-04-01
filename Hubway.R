#Import Data
getwd()
hw_data<-read.csv("201612-hubway-tripdata.csv")

#install package to use SQL
install.packages("sqldf")
library(sqldf)
library(ggplot2)

#Defination
#column names
colnames(hw_data)
str(hw_data)


#SQL Statements
DF=sqldf('select * from hw_data where gender = "2"')
DF_cnt=sqldf('select count(*) from hw_data')
DF_cnt

#plot
qplot(hw_data$gender,data=hw_data, geom="histogram")

DF_QRY=sqldf('select "start.station.name", count(*) total from hw_data  group by "start.station.name" ORDER BY total desc')
DF_QRY


DF_AGE_GENDER=sqldf('select "2017"-"birth.year" age, gender, count(*) total from hw_data  group by "2017"-"birth.year", gender ORDER BY 1 desc')
DF_AGE_GENDER

DF_AGE=sqldf('select "2017"-"birth.year" age, count(*) total from hw_data  group by "2017"-"birth.year" ORDER BY 1 desc')
DF_AGE

DF_AGE_FINAL=sqldf('select * FROM DF_AGE WHERE age <> "2017" ORDER BY 1 ')
DF_AGE_FINAL

DF_AGE_GENDER_FINAL=sqldf('select * FROM DF_AGE_GENDER WHERE age <> "2017" ORDER BY 1 ')
DF_AGE_GENDER_FINAL

#add description to gender
gender_value<-c(0,1,2)
gender_desc<-c("Other","Male","Female")
gender_map<-data.frame(gender_value, gender_desc)
str(gender_map)

DF_AGE_GENDER_FINAL1<-merge(DF_AGE_GENDER_FINAL,gender_map, by.x = "gender", by.y = "gender_value")
DF_AGE_GENDER_FINAL1

str(DF_AGE)
###################################################################
#plot
###################################################################
qplot(DF_AGE_FINAL$age,data=DF_AGE_FINAL, geom="histogram")

#qplot
qplot(age, total, data=DF_AGE_FINAL)

#Color, size, shape and other aesthetic attributes
#qplot(age, total, data=DF_AGE_FINAL, color=color, shape=cut, alpha=I(1/2))

#Plot geoms
qplot(age, total, data=DF_AGE_FINAL, geom=c("point", "smooth"),
      xlab = "Age",
      ylab = "No of Customers",
      main = "Total Number of Hubway Rider by Age for December 2016")

#adding smoother (Liner Model)
qplot(age, total, data=DF_AGE_FINAL, geom=c("point", "smooth"), method="lm",
      xlab = "Age",
      ylab = "No of Customers",
      main = "Total Number of Hubway Rider by Age for December 2016")


#Boxplots and jittered points
qplot(gender_desc, total/age, data=DF_AGE_GENDER_FINAL1, geom="jitter")
qplot(gender_desc, total/age, data=DF_AGE_GENDER_FINAL1, geom="boxplot")

qplot(age, data=DF_AGE_GENDER_FINAL, geom="histogram", fill=total)

qplot(age, data=DF_AGE_GENDER_FINAL, geom="bar")

qplot(age, data=DF_AGE_GENDER_FINAL, geom="density", color=gender)

qplot(age, data=DF_AGE_GENDER_FINAL, geom="histogram", binwidth=0.1)

library(maps)
data(us.cities)
big_cities <- subset(us.cities, pop>500000)
qplot(long, lat, data=big_cities) + borders("state", size=0.5)

###################################################################
#creating a ggplot-color
###################################################################

ggplot(data = DF_AGE_FINAL) + 
  geom_point(mapping = aes(x = age, y = total))

ggplot(data = DF_AGE_GENDER_FINAL1) + 
  geom_point(mapping = aes(x = age, y = total, color = gender_desc))
   
ggplot(data = DF_AGE_GENDER_FINAL1, mapping = aes(x = age, y = total)) + 
  geom_point(mapping = aes(color = gender_desc)) + 
  geom_smooth(data = filter(DF_AGE_GENDER_FINAL1, gender_desc == "Female"))
