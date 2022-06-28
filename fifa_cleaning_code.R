
#reading the dataset
fifa <- read.csv("C:/Users/solo2/OneDrive/Documents/Notes/Semester 2/lab/adv sats/project/fifa_cleaned.csv")

#to view the data
View(fifa)

# To know the size of data
dim(fifa)

#summary statistics for all the columns of the data
summary(fifa)

# displaying the internal structure of the data
str(fifa)

#to check null values
any(is.na(fifa))

#to check the count of null values
sum(is.na(fifa))

#To get the specific column with null values
sum(is.na(fifa$TotalCharges))
# OR
colSums(is.na(fifa))

#to remove columns 
fifa_1 <- fifa[-c(1,20,24:29,61:92)]

#to view the clean data fifa_1
View(fifa_1)

#to check the count of null values of the new data fifa_1
sum(is.na(fifa_1))

#To get the specific column with null values of the new data fifa_1
colSums(is.na(fifa_1))

#to remove the null values
fifa_1 <- na.omit(fifa_1)

# is there still a null value
sum(is.na(fifa_1))

#to check null values
any(is.na(fifa_1))

#To get the specific column with null values of the new data fifa_1
colSums(is.na(fifa_1))
#to view the data again
View(fifa_1)

summary(fifa_1)

#to export clean dataset
write.csv(fifa_1, "C:/Users/solo2/OneDrive/Documents/Notes/Semester 2/lab/adv sats/fifa_clean.csv")
