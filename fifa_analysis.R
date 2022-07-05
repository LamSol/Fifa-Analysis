#installing dependencies
install.packages("gridExtra")
install.packages("tidyverse")

#importing dependencies
library(gridExtra)
library(tidyverse)

#Data cleaning 


#reading the dataset
fifa <- read.csv("C:/Users/solo2/OneDrive/Documents/Notes/Semester 2/lab/adv sats/fifa_cleaned.csv")

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
colSums(is.na(fifa))

#to remove columns unwanted columns
fifa_1 <- fifa[-c(1,20,22,24:30,61:92)]

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

#To get the specific column with null values of the new data fifa_1
colSums(is.na(fifa_1))
#to view the data again
View(fifa_1)

#to export clean dataset
write.csv(fifa_1, "C:/Users/solo2/OneDrive/Documents/Notes/Semester 2/lab/adv sats/fifa_clean.csv")

#importing the cleaned data
df = read.csv(file = "C:/Users/solo2/OneDrive/Documents/Notes/Semester 2/lab/adv sats/project/fifa_clean.csv", stringsAsFactors = FALSE)
df = as_tibble(df)

#convert the first letter to uppercase
colnames(df) = str_to_title(colnames(df))
View(df)

#cleaning the column names
df = df %>% 
  rename(
    Dob = Birth_date,
    Height = Height_cm,
    Weight = Weight_kgs,
    Overall = Overall_rating,
    Value = Value_euro,
    Wage = Wage_euro,
    International_reputation = International_reputation.1.5.,
    Weak_foot = Weak_foot.1.5.,
    Skill_moves = Skill_moves.1.5.
  )
View(df)

#defining df1
df1 <- select(df, X, Name, Nationality, Age, Overall, Value, Wage, Positions)

#view df1
head(df1, 10)
  
  
#numeric datatypes
  df_numeric<-df[c('Age', 
                   'Height', 
                   'Weight', 
                   'Overall', 
                   'Potential', 
                   'Value', 
                   'Wage', 
                   'International_reputation', 
                   'Weak_foot', 
                   'Skill_moves', 
                   'Crossing', 
                   'Finishing', 
                   'Heading_accuracy', 
                   'Short_passing', 
                   'Volleys', 
                   'Dribbling', 
                   'Curve', 
                   'Freekick_accuracy', 
                   'Long_passing', 
                   'Ball_control', 
                   'Acceleration', 
                   'Sprint_speed', 
                   'Agility', 
                   'Reactions', 
                   'Balance', 
                   'Shot_power', 
                   'Jumping', 
                   'Stamina', 
                   'Strength', 
                   'Long_shots', 
                   'Aggression', 
                   'Interceptions', 
                   'Positioning', 
                   'Vision', 
                   'Penalties', 
                   'Composure', 
                   'Marking', 
                   'Standing_tackle', 
                   'Sliding_tackle')]

# defining categorical datatypes
df_categorical<-df[c('Name', 
                     'Full_name', 
                     'Dob', 
                     'Positions', 
                     'Preferred_foot', 
                     'Work_rate', 
                     'Body_type', 
                     'Club_team', 
                     'Club_position')]

#to check the unique body types
unique(df[c("Body_type")])

#to check count of unique body types
n_distinct(df$Body_type)
#body types are - Normal,Lean, Stocky


#to check the unique positions
df_position <- unique(df[c("Positions")])
View(df_position)
#display the counts of df_position
n_distinct(df$Positions)
#contains 204 unique postions

#Make the column "Positions" have only one data per row
df$Positions <- gsub(" ", "", substr(df$Positions,1,3))
df$Positions <- gsub(",", "", substr(df$Positions,1,3))
#to check the unique Positions again
df_position <- unique(df[c("Positions")])
View(df_position)
n_distinct(df$Positions)
#this time the unique postions is reduced to 15

#group the positions in GK, DEF, MID,FWD
x <- as.factor(df$Positions)
levels(x) <- list(GK =c("GK"),
                  DEF =c("LWB","LB","CB","RB","RWB"),
                  MID = c("LW","LM","CDM","CM","CAM","RM","RW"),
                  FWD = c("CF","ST"))
df <-mutate(df,Position = x)
#viewing the data again
View(x)

#--------------------------------------------------------------------------------

##EDA##

#EDA distribution of players based on the age
g_age <- ggplot(data = df, aes(Age))
g_age + 
  geom_histogram(col="orange", aes(fill = ..count..)) + ggtitle("Distribution based on Age")

#--------------------------------------------------------------------------------

#relation between the Age of the players and their general playing position.
g_age + 
  geom_density(col="orange", aes(fill = Position), alpha=0.5, bins = 30) + facet_grid(.~Position) + 
  ggtitle("Distribution based on Age and Position")

#--------------------------------------------------------------------------------

#We see that the majority number of players have an overall rating of around 75.
g_overall <- ggplot(data = df, aes(Overall))
g_overall + 
  geom_histogram(col="orange", aes(fill = ..count..)) + ggtitle("Distribution based on Overall Rating")

#--------------------------------------------------------------------------------

#player rating vs value in euro
df %>% ggplot(aes(x=Overall,y=Value)) + geom_point() + geom_jitter() +
  labs(x = "player rating", y = "player value (euro)", 
       title = "Plot of player rating vs player value")

#--------------------------------------------------------------------------------

# potential vs. value
df %>% ggplot(aes(x=Potential,y=log(Value))) +
  geom_point() + geom_smooth(method='lm', formula= y~x) +
  labs(x="player potential", title = "Plot of potential vs. player value")



#--------------------------------------------------------------------------------

#multiple regression model by keeping value_euro as the dependent variable

lm.fit.value = lm(Value ~
                    Age+Overall+Potential+Wage+
                    International_reputation+
                    Stamina+Sliding_tackle+Standing_tackle+Height, data = df)
summary(lm.fit.value)

