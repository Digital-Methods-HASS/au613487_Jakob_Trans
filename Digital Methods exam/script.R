#GDP and politics in Scandinavia


#Installing packages

install.packages("tidyverse")

install.packages("ggthemes")

#Running packages

library(tidyverse)

library(ggthemes)

#Creating a directory to store my data

dir.create("data")

#downloading data

download.file("https://raw.githubusercontent.com/Digital-Methods-HASS/au613487_Jakob_Trans/main/rawdata.csv",
              "data/rawdata.csv", mode = "wb")

#Opening the data and making R count missing data as missing.
#I will name this new dataset 'cleandata', as I am going to clean it up and I do not want to mess with the raw data.

cleandata <- read_csv("data/rawdata.csv", na = "NULL")



#Cleaning up the data by removing the colomn called "Flag Codes", as it isnt useful for the project.

cleandata <- cleandata[, -8]


#Filtering the Scandinavian countries, Scandinavia and OECD

denmark <- filter(cleandata, cleandata[,1] == "DNK")
norway <- filter(cleandata, cleandata[,1] == "NOR")
finland <- filter(cleandata, cleandata[,1] == "FIN")
sweden <- filter(cleandata, cleandata[,1] == "SWE")
oecd_world <- filter(cleandata, cleandata[,1] == "OECD")
scandinavia <- filter(cleandata, LOCATION == "DNK" |LOCATION == "NOR" |LOCATION == "SWE" |LOCATION == "FIN")


#Making a new coloumn called government and adding values to it.
  #For the sake of simplicity, I will be moving parties into groups of 3. 
    #l: left wing, r: right wing, ce: centrist parties.
  #I name centrist paties 'ce', so that r doesnt confuse it with the function c.
  #The Party that holds the office of prime minister for the biggest portion of a year will be assigned the entire year.
  #The First part is '#Denmark governments'

scandinavia$gov <- c("l", "l",
                      "ce", "ce","ce", "ce",
                      "l", "l", "r", "l", "l", "l", "l", "l", "l", "l", "l",
                      "r", "r", "r", "r", "r", "r", "r", "r", "r", "r", "l",
                      "l", "l", "l", "l", "l", "l", "l", "l",
                      "r", "r", "r", "r", "r", "r", "r", "r", "r", "r",
                      "l", "l", "l",
                      "r", "r", "r", "r", 
                      "l", 
                      #Finland governments
                      "ce", "ce", 
                      "l", "l", "l", "l", 
                      "r", 
                      "l", "l", "l", "l", "l", "l", "l", "l", "l", "l", 
                      "r", "r", "r", "r", 
                      "ce", "ce", "ce", "ce", 
                      "l", "l", "l", "l", "l", "l", "l", "l", 
                      "ce", "ce", "ce", "ce", "ce", "ce", "ce", "ce",
                      "r", "r", "r", "r", 
                      "ce", "ce", "ce", "ce", 
                      "l", 
                      #Norway governments
                      "ce", 
                      "l", "l", 
                      "ce", 
                      "l", "l", "l", "l", "l", "l", "l", "l", 
                      "r", "r", "r", "r", 
                      "l", "l", "l", "l", 
                      "r", 
                      "l", "l", "l", "l", "l", "l", "l", 
                      "ce", "ce", "ce", 
                      "l", 
                      "ce", "ce", "ce", "ce", 
                      "l", "l", "l", "l", "l", "l", "l", "l", 
                      "r", "r", "r", "r", "r", "r", 
                      #Sweden governments
                      "l", "l", "l", "l", "l", "l", "l", 
                      "ce", "ce", 
                      "r", 
                      "ce", "ce", "ce", 
                      "l", "l", "l", "l", "l", "l", "l", "l", "l", 
                      "r", "r", "r", 
                      "l", "l", "l", "l", "l", "l", "l", "l", "l", "l", "l", "l",
                      "r", "r", "r", "r", "r", "r", "r", "r",
                      "l", "l", "l", "l", "l")


#Percentage of the time that the scandinavian countries had either leftwing, right wing og centrist governments.
  #Firstly i create the following vector:

percent_gov <- scandinavia %>%
  filter(LOCATION != "ce") %>%
  count(LOCATION, gov) %>%
  group_by(LOCATION) %>%
  mutate(percent = (n / sum(n)) * 100) %>%
  ungroup()

  #I want to create a ggplot that illustrates percentage of time certain parties spent in power.
  #I make costum colors to make my illustration better, and make "ce"=green, "l"=red, "r"=blue
    #I did this because leftwing and right wing parties in scandinavia have tradionally used certain colors

mycolors <- c("green", "red", "blue")

  #I create the ggplot and add some aesthetics to make the plot more pleasurable to the eye.

percent_gov %>%
  ggplot(aes(x = LOCATION, y = percent, fill = gov,)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Parties in power in Scandinavia",
       x = "Countries",
       y = "percentage of years spent in power")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_fill_manual(values = mycolors, name ="Government", labels =c("centrist party",
                                                                      "left wing party",
                                                                      "Right wing party"))



#Making af ggplot of GDP per capita in scandinavian countries

scandinavia %>% 
  ggplot(aes(x = TIME, y = Value, color = LOCATION)) +
  geom_line(size = 1.1, alpha = 0.7)+
  labs(title = "GDP per capita in Scandinavian countries",
       x = "Time in years",
       y = "GDP per capita")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_colour_discrete(name = "Countries", labels = c("Denmark", "Finland", "Norway", "Sweden"))



#Comparing GDP per capita in Scandinavian countries to the world average for OECD countries
  #Firstly, I creat a new vector which Includes both world OECD averages and all Scandinavian countries 

scan_and_oecd_avg <- filter(cleandata, LOCATION == "DNK" |LOCATION == "NOR" |LOCATION == "SWE"
                            |LOCATION == "FIN" |LOCATION == "OECD")

  #Then i make a ggplot that has both scandinavian countries and OECD World average in the same plot

scan_and_oecd_avg %>% 
  ggplot(aes(x = TIME, y = Value, color = LOCATION)) +
  geom_line(size = 1.2, alpha = 0.7)+
  labs(title = "GDP per cap: Scandinavia compared to OECD average",
       x = "Time in years",
       y = "GDP per capita",
       color = "LOCATION")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_colour_discrete(name = "Countries", labels = c("Denmark", "Finland", "Norway", "Sweden", "OECD_avg"))





#Making a ggplot for every country, that shows the correlation between political party and GDP per cap
  #Starting out by making vectors for each country that includes 'gov'

denmark_gov <- filter(scandinavia, LOCATION == "DNK")
finland_gov <- filter(scandinavia, LOCATION == "FIN")
norway_gov <- filter(scandinavia, LOCATION == "NOR")
sweden_gov <- filter(scandinavia, LOCATION == "SWE")


  #Denmark

denmark_gov %>% 
  ggplot(aes(x = TIME, y = Value, color = gov,)) +
  geom_point() +
  labs(title = "GDP per capita and government in Denmark",
       x = "Year",
       y = "GDP Per capita")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_color_manual(values = mycolors, name ="Government", labels =c("Centrist party",
                                                                      "Left wing party",
                                                                      "Right wing party"))


  #Finland

finland_gov %>% 
  ggplot(aes(x = TIME, y = Value, color = gov,)) +
  geom_point() +
  labs(title = "GDP per capita and government in Finland",
       x = "Year",
       y = "GDP Per capita")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_color_manual(values = mycolors, name ="Government", labels =c("centrist party",
                                                                      "left wing party",
                                                                      "Right wing party"))


  #Norway

norway_gov %>% 
  ggplot(aes(x = TIME, y = Value, color = gov,)) +
  geom_point() +
  labs(title = "GDP per capita and government in Norway",
       x = "Year",
       y = "GDP Per capita")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_color_manual(values = mycolors, name ="Government", labels =c("Centrist party",
                                                                      "Left wing party",
                                                                      "Right wing party"))

  #Sweden

sweden_gov %>% 
  ggplot(aes(x = TIME, y = Value, color = gov,)) +
  geom_point() +
  labs(title = "GDP per capita and government in Sweden",
       x = "Year",
       y = "GDP Per capita")+ 
  theme_fivethirtyeight()+ 
  theme(axis.title = element_text())+ 
  scale_color_manual(values = mycolors, name ="Government", labels =c("Centrist party",
                                                                      "Left wing party",
                                                                      "Right wing party"))
