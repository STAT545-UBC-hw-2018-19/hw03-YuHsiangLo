Homework 03: Use dplyr/ggplot2 to manipulate and explore data
================
Roger Yu-Hsiang Lo
2018-10-02

-   [Bring rectangular data in](#bring-rectangular-data-in)
-   [Task 1: Maximum and minimum of GDP per capita within the continents](#task-1-maximum-and-minimum-of-gdp-per-capita-within-the-continents)
-   [Task 2:](#task-2)
-   [R Markdown](#r-markdown)
-   [Including Plots](#including-plots)

Bring rectangular data in
-------------------------

-   Load the `Gapminder` data and `tidyverse` package:

``` r
library(gapminder)
library(tidyverse)
```

-   Some sanity check to make sure the `Gapminder` data was loaded properly:

``` r
head(gapminder) %>%
  knitr::kable(.)
```

| country     | continent |  year|  lifeExp|       pop|  gdpPercap|
|:------------|:----------|-----:|--------:|---------:|----------:|
| Afghanistan | Asia      |  1952|   28.801|   8425333|   779.4453|
| Afghanistan | Asia      |  1957|   30.332|   9240934|   820.8530|
| Afghanistan | Asia      |  1962|   31.997|  10267083|   853.1007|
| Afghanistan | Asia      |  1967|   34.020|  11537966|   836.1971|
| Afghanistan | Asia      |  1972|   36.088|  13079460|   739.9811|
| Afghanistan | Asia      |  1977|   38.438|  14880372|   786.1134|

Task 1: Maximum and minimum of GDP per capita within the continents
-------------------------------------------------------------------

Suppose that we are interested in the maximum and minumum of GDP per capita in the year of 2007. The restuls are summarized in the following table:

``` r
gapminder %>%
  filter(year == 2007) %>%
  group_by(continent, year) %>%
  summarise(max = max(gdpPercap), min = min(gdpPercap)) %>%
  knitr::kable(.)
```

| continent |  year|       max|         min|
|:----------|-----:|---------:|-----------:|
| Africa    |  2007|  13206.48|    277.5519|
| Americas  |  2007|  42951.65|   1201.6372|
| Asia      |  2007|  47306.99|    944.0000|
| Europe    |  2007|  49357.19|   5937.0295|
| Oceania   |  2007|  34435.37|  25185.0091|

In the following plot, we try to represent this information in a plot. Of course, now that we are using a plot, we can include the maxmimum and minimum from all the years:

``` r
max <- gapminder %>%
  group_by(continent, year) %>%
  summarise(extreme = 'Maximum', gdpPercap = max(gdpPercap))  # Extract max data

min <- gapminder %>%
  group_by(continent, year) %>%
  summarise(extreme = 'Minimum', gdpPercap = min(gdpPercap))  # Extract min data

range <- rbind(max, min)  # Combine the two data frames

ggplot(range, aes(x = year, y = gdpPercap, color = extreme)) +
  facet_grid(~ continent) +
  geom_line() +
  scale_y_log10() +  # Change the scale
  labs(x = 'Year', y = 'GDP per capita') +  # Add labels
  theme(legend.title = element_blank())  # Remove legend title
```

<img src="homework_03_Use_dplyr_ggplot2_to_manipulate_and_explore_data_files/figure-markdown_github/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

We can see that the range of GDP within Oceania is very small over the years(but again only the data from Australia and New Zealand are included in this continent), and the range is biggest in Asia overall. We can also observe that the gap between the highest and lowest GDP was increasing in Americas.

Simiarly, we can investigate how the range associated with life expectancy changes over the years across different continents:

``` r
max <- gapminder %>%
  group_by(continent, year) %>%
  summarise(extreme = 'Maximum', lifeExp = max(lifeExp))

min <- gapminder %>%
  group_by(continent, year) %>%
  summarise(extreme = 'Minimum', lifeExp = min(lifeExp))

range <- rbind(max, min)

ggplot(range, aes(x = year, y = lifeExp, color = extreme)) +
  facet_grid(~ continent) +
  geom_line() +
  labs(x = 'Year', y = 'Life expectancy') +
  theme(legend.title = element_blank())
```

<img src="homework_03_Use_dplyr_ggplot2_to_manipulate_and_explore_data_files/figure-markdown_github/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

We see that both maximum and minimum of life expectancy shifted upward over the years within each continent. Furthermore, for Americas and Europe, the gap between the extremes was closing through time. Also notice that the maximum life expectancy is approximately the same in 2007 across continents.

Task 2:
-------

R Markdown
----------

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

Including Plots
---------------

You can also embed plots, for example:

<img src="homework_03_Use_dplyr_ggplot2_to_manipulate_and_explore_data_files/figure-markdown_github/pressure-1.png" style="display: block; margin: auto;" />

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
