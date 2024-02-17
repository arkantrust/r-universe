# Transforming and Filtrating Data

In this fourth module we will study how to create objects with a subset of the original observations (filter) and transform variables.

At the end of this module you will be able to use the R package [dplyr]() to:

  - Filter observations on a data object.
  - Select, transform and create variables in an object with data in R.
  - Join objects with data.
  
Here is a [youtube video](https://www.youtube.com/watch?v=-sx0ZG-yUF8) with these topics.

# Notes

These notes were taken from the book "[*Empezando a transformar bases de datos con R y dplyr*](./data-bases.pdf)" by Julio César Alonso.

## pipe operator

The pipe operator `%>%` is used to perform various operations on a value without having to save the intermediate values. e.g.:

``` r
r1 <- sqrt(65)
r2 <- log(r1)
round(r2, digits = 2) # 2.09
```

It can also be written like this:

``` r
round(log(sqrt(65)), digits = 2) # 2.09
```

But the moment we get multiple operations the code will be illegible. Instead we use the pipe operator from the dplyr package (it also comes with any package from tidyverse).

``` r
# remember to install dplyr with installpackages("dplyr")
library(dplyr)

# data enters the pipe 
65 %>%         

  sqrt() %>% # compute the square root of whatever is in the pipe

  log() %>% # compute the log of whatever is in the pipe

  round( digits = 2) # 2.09
```

This looks more cleaner, intuitive and it's easy to use.

## The `tibble` class

A `tibble` object is like a `data.frame` with some key differences:

1. Tibble objects can have numbers and symbols in variable (column) names, while data.frame objects do not allow this.

2. When calling a tibble object in the console, only the first 10 rows and all columns that fit in the console are displayed. In the case of a data.frame object, all data is presented in the console, or up to 1000 lines in RStudio. Large datasets may be challenging to visualize. Additionally, only tibble objects, along with their names, display each column's class (similar to the str() function).

3. When extracting a subset of variables from a tibble object, you always get another tibble. For a data.frame object, extracting a subset of variables may result in either a data.frame or sometimes a vector.

4. Tibble objects can have a column (variable) of class list, which is not possible in a data.frame.

## The `filter()` function

The `filter()` function is used to select a subset of the observations in a dataset. The first argument is the dataset, and the second argument is the condition that the observations must meet to be included in the subset. The condition is written using the same syntax as the `subset()` function.

``` r
library(dplyr)

# filter the dataset to include only the observations where the variable "age" is greater than 30
filter(data, age > 30)
```
``` r
# remember to install.packages("gapminder")
library(gapminder)

data("gapminder")

class(gapminder)

gapminder

library(dplyr)

# filtering
americas_2007 <- filter(gapminder, 
                      continent == "Americas" &
                         year == 2007 ) 

americas_2007

Euro_ame_2007 <- gapminder %>% 
  filter(continent %in% c("Americas", "Europe")) %>% 
  filter(year == 2007)

Euro_ame_2007
```

## The `arrange()` function

The `arrange()` function is used to sort the observations in a dataset. The first argument is the dataset, and the second argument is the variable by which the observations will be sorted. The default is to sort in ascending order, but you can use the `desc()` function to sort in descending order.

``` r
oceania_s21 <- gapminder %>% 
  filter(continent == "Oceania") %>% 
  filter(year > 2000 ) %>% 
  arrange(country)
```

If we wanted to sort the dataset in descending order, we would use the `desc()` function.

``` r
oceania_s21 <- gapminder %>% 
  filter(continent == "Oceania") %>% 
  filter(year > 2000 ) %>% 
  arrange(desc(year))

oceania_s21
```

## The `group_by()` function

Summarizing data by grouping common features, like averaging life expectancies by continent for a specific year or calculating total population per continent, involves two steps. First, use group_by() to group by a criterion (e.g., continent), and then use summarise() with functions like sum() for totals or mean() for averages.

For example, let's find the average life expectancy at birth by continent for the year 2007. This involves first filtering (`filter()`) the data to only include 2007, then grouping them (`group_by()`) by continent, and finally summarizing (`summarise()`) the data with the group mean (`mean()`).

``` r
EV_continetes <- gapminder %>% 
  filter(year ==2007) %>% 
  group_by(continent) %>% 
  summarise(averageExp = mean(lifeExp))

EV_continetes 
```

We can also create multiple variables in the summary. For instance, let's say we want to include the total population of the continent and the number of countries in each continent, the `count()` function counts how many cases there are per group. We can achieve this by separating with commas the new variables we want to create using the `summarise()` function.

``` r
BD_continetes <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(averageExp = mean(lifeExp), 
            totalPop = sum(pop), 
            countries = count()) %>% 
  arrange(desc(averageExp))

BD_continetes
```

In some cases, instead of aggregating data with a sum or average, we aim to find the case with the highest value for a variable or the top 10 observations with the highest values (top 10) in their respective groups. In such instances, we use the verb top_n(). The first argument is the data, passed using the %>%, the second is n, the number of top values we want to obtain, and the last is the variable for which we seek the top n cases.

For example, suppose we want to find the countries in each continent with the highest life expectancy at birth in 2007. We can do this as follows:

``` r
gapminder %>% 
  filter(year == 2007) %>% 
  group_by(continent) %>% 
  top_n(1, lifeExp)
```