#Installing and running scripts

install.packages("gganimate")
install.packages("gapminder")
install.packages("ggplot2")
library(tidyverse)
library(gganimate)
library(gapminder)
library(ggplot2)
head(gapminder)
unique(gapminder$year)
head(gapminder)

#I run the following to see the plot
ggplot(subset(gapminder, year == 1952), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()


#Q1. Why does it make sense to have a log10 scale on x axis?
  
I think it is ecause if we didnt have a log10 scale, the data would be so far streched, that i would be har to see what was going on. That would make a visualisation useless.
The GDP-difference is too big between the countries to have a non-log10 on the x-axis.


#Q2. What country is the richest in 1952 (far right on x axis)? 
  
view(gapminder)

I run the following line of code, and get a list the countries by GDP:
gapminder %>%
  filter(year==1952) %>%
  arrange(desc(gdpPercap))

Based on GDP per capita Kuwait is the richest country in the world in 1952.


# Generating a plot for 2007
I run the following Scripts

ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() 


#Q3. Can you differentiate the continents by color and fix the axis labels?

I use the following script to sort the continents by color and changed the name of the axis labels:
  
  ggplot(subset(gapminder, year == 2007), aes(gdpPercap, lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() +
  labs(x = "Gdp per capita", y = "Life Expentancy")


#Q4. What are the five richest countries in the world in 2007?

  I run the following line of code, and get a list the countries by GDP:
  gapminder %>%
  filter(year==2007) %>%
  arrange(desc(gdpPercap))

Based on GDP per capita Norway is the richest country in the world in 2007


# making the plot move 1

anim <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()  # convert x to log scale
anim


anim + transition_states(year, 
                         transition_length = 1,
                         state_length = 1)

#Option 2: Make the animation smoother

anim2 <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10() + # convert x to log scale
  transition_time(year)
anim2


#Q5 Can you add a title to one or both of the animations above that will change in sync with the animation?
[hint: search labeling for transition_states() and transition_time() functions respectively]


I then add titles to the animation using the following script that I found online (link in bottom)

anim2 + transition_time(year) +
  labs(title = "Year: {frame_time}")


At this point I spent a long time struggling with the assignment, and I had to get some sleep. Therefore i did not complete the rest of the assignments.
Even though i struggled for a long time, installing packages like 'rtools', I could not get my animations to work.
I think my computer was unable to install 'gganimate' for some reason. Even though RStudio said that it was installed, it did not run correctly when i used the command library(gganimate).
I kept on getting the file code:'Advarselsbesked: file_renderer failed to copy frames to the destination directory' 
Since I was not able to see the animations, it was extremely hard to know if my coding was correct, and I only made it this far thanks to the help of my great colleagues. 


https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/?fbclid=IwAR07rcTVzP6GZ5d_xoYpbXes4lv4ufJ3vorxfsMMoeTM5QSnqmdsNm1EwRk
