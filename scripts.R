#Week-04,Data Viz-creating graphics with ggplot2

library(tidyverse)

gapminder <- read_csv("data/gapminder.csv")

gapminder_1977 <- filter(gapminder,year==1977)

ggplot(data = gapminder_1977) # step 1 in plotting; nothing is shown

glimpse(gapminder_1977) #see all variable name correctly


#step 2 in plotting; nothing is shown again
ggplot(
  data = gapminder_1977,
   mapping = aes(x=gdpPercap,y=lifeExp,colour=continent, size=pop)    
       )

#step 3 in plotting; addition of + geom_point () shows plot
ggplot(
  data = gapminder_1977,
  mapping = aes(x=gdpPercap,y=lifeExp,colour=continent, size=pop))+
    geom_point()

#To make plot more meaningful, add logarithmic scales to x axis variable

ggplot(
  data = gapminder_1977,
  mapping = aes(x=gdpPercap,y=lifeExp,colour=continent, size=pop))+
  geom_point()+
  scale_x_log10()

# change of aesthetic variables position to geom_point, it gives the same plot output
ggplot(
  data = gapminder_1977
) +
  geom_point( mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop) )

# notice the change in colour and size desingnations
  
ggplot(gapminder_1977,aes(x=gdpPercap,y=lifeExp))+
         geom_point(colour="blue",size=5)

# To see line plot from the same variables
ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,colour=continent, group=country))+
  geom_line()

#To see if the graph changes with change in order of assigning aesthetics to variables, no change noticed.

ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,group=country,colour=continent))+
  geom_line()

#Visualise both lines and points in the plot
ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,group=country,colour=continent))+
  geom_line()+
  geom_point()

#Visualise so that lines are coloured but points are black, by only mapping colour to continet at geom_line()
ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,group=country))+
  geom_line(mapping = aes(colour=continent))+
  geom_point()

#The same plot output with different way
ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,group=country,colour=continent))+
  geom_line()+
  geom_point(colour="black")

#change of geom_X order changes the plot output, i.e geom_point ahead of geom_line
ggplot(
  data = gapminder,
  mapping = aes(x=year,y=lifeExp,group=country,colour=continent))+
  geom_point(colour="black")+
  geom_line()

#data
  
ggplot(
  data = gapminder,
  mapping = aes(x=gdpPercap,y=lifeExp))+
  geom_point()

#Giving alpha (transparency) value to point and logarithmic transformation of x variable.

ggplot(data = gapminder,aes(x=gdpPercap,y=lifeExp))+
geom_point(alpha=0.5)+
  scale_x_log10()

#Fitting linear line with additional layer of geom_smooth, not to forget "+" after each layer
ggplot(data = gapminder,aes(x=gdpPercap,y=lifeExp))+
  geom_point()+
  scale_x_log10()+
geom_smooth(method = "lm")

#To make linear line thicker or thiner, assign size at geom_smooth layer
ggplot(data = gapminder,aes(x=gdpPercap,y=lifeExp))+
  geom_point()+
  scale_x_log10()+
  geom_smooth(method = "lm", size=2.0)

#This layers takes values argument to differentiate colour of continents.
ggplot(data = gapminder,aes(x=gdpPercap,y=lifeExp,colour=continent))+
  geom_point()+
  scale_x_log10()+
  scale_colour_manual(values = c("red","green","blue","purple","black"))

#Application of a different layer like scale_color_brewer which takes palette argument instead of values.
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() + 
  scale_x_log10() +
  scale_color_brewer(palette = "Set1") #"Set1" palette for qualitative data

#Pick up countries that starts with "A"
a_countries <- filter(gapminder,str_starts(country,"A"))

#produce separate output plots with facet_wrap argument
ggplot(data = a_countries,aes(x=year,y=lifeExp,colour=continent))+
  geom_line()+
  facet_wrap(~country)

#Challenge 12
ggplot(data = gapminder,aes(x=gdpPercap,y=lifeExp, colour=continent,size=pop))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)

#Challenge 13, creating density plot with continent fill 
gapminder_plot <- ggplot(data = gapminder, aes(x = pop, fill=continent)) +
  geom_density(alpha=0.4) + 
  facet_wrap( ~ year) + 
  scale_x_log10()

ggsave(filename = "results/density_plot.png", plot = gapminder_plot, width = 12, height = 10, dpi = 300, units = "cm")

#Creating rough plot
rough_plot <- ggplot(data=a_countries,aes(x=year,y=lifeExp,colour=continent))+
  geom_line()+
  facet_wrap(~country)

# we have stored the plot above into a variable named rough_plot. 
#We can continue adding layers to this variable and they will be applied to the plot as usual. 

rough_plot +
  labs(
    title = "Figure 1", #main title of figure
    x="Year", #x-axis title
    y="Life Expectancy", #y-axis title
    colour="continent" #title of legend
  )

#Adding meaning title and caption to the above plot
rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries",
    caption = "Data source: Gapminder",
    x = "Year",              
    y = "Life Expectancy",  
    color = "Continent"      
  ) 

#The previous ploy was applied with default theme of theme_grey

rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries",
    caption = "Data source: Gapminder",
    x = "Year",              
    y = "Life Expectancy",  
    color = "Continent"      
  ) +
  theme_bw()

#We can modify individual elements of the theme of the plot using 
#the theme() function

rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries",
    caption = "Data source: Gapminder",
    x = "Year",              
    y = "Life Expectancy",  
    color = "Continent"      
  ) +
  theme_bw()+
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold")
  )
#Challenge 2

lifeExp_plot <- rough_plot +
  labs(
    title = "Growth in life expectancy for 'A' countries",
        x = "Year",              
    y = "Life Expectancy",  
    color = "Continent"      
  ) +
  theme_bw()+
  theme(
    strip.background = element_blank(),
    panel.grid.major = element_line(size = 1),
    axis.title = element_text(size = 10, colour = "blue"),
    legend.position = "bottom",
  )
ggsave(filename = "results/lifeExp.png",plot = lifeExp_plot,width = 12,height = 10,dpi = 300,units = "cm")

#the above function saved the plot as as a file name of "lifeExp.png"

#Sometimes, one plot cannot tell the whole story and you need to combine
#multiple plots into a single figure. There are several ways you can perform this, 
#it can be done using the cowplot package

install.packages("cowplot")
library(cowplot)

#The plot_grid() function from cowplot allows to combine multiple ggplot objects into a single figure. 
#Save each individual plot into a variable and provide them all as arguments to plot_grid()

plot1 <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + geom_point()
plot2 <- ggplot(gapminder, aes(x = continent, y = lifeExp)) + geom_boxplot()
plot3 <- ggplot(gapminder, aes(x = gdpPercap, y = pop)) + geom_point()
plot4 <- ggplot(gapminder, aes(x = lifeExp, y = pop)) + geom_point()

# Combining them into one
plot_grid(plot1, plot2, plot3, plot4)

plot_grid(plot1, plot2, plot3, plot4, rel_heights = c(1, 3))

plot_grid(plot1, plot2, plot3, plot4, labels = "AUTO")# labels figures as "A","B","C","D" in uppercase.




