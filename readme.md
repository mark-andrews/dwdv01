# Introduction to Data Wrangling and Data Visualization using R

In this course, we provide a comprehensive practical introduction to data wrangling and data visualization using R.
In the coverage of data wrangling, we will cover tools provided by R's `tidyverse`, including `dplyr`, `tidyr`, `purrr`, etc.
We will cover how to read data of different types into R using `readr` and related packages, and then cover in detail all the `dplyr` tools such as `select`, `filter`, `mutate`, `summarize`, etc. We will also cover the pipe operator (`%>%`) to create data wrangling pipelines that take raw messy data on the one end and return cleaned tidy data on the other. We will also how to reshape data using pivots, and how to merge data sets using merge operations.
For the topic of visualization, we provide a comprehensive introduction to data visualization in R using ggplot. We begin by covering the major types of plots for visualizing distributions of univariate data: histograms, density plots, barplots, and Tukey boxplots. In all of these cases, we will consider how to visualize multiple distributions simultaneously on the same plot using different colours and "facet" plots. We then turn to the visualization of bivariate data using scatterplots. Here, we will explore how to apply linear and nonlinear smoothing functions to the data, how to add marginal histograms to the scatterplot, add labels to points, and scale each point by the value of a third variable. 

## Intended Audience

This course is aimed at anyone who is involved in real world data analysis, where the raw data is messy and complex, and where understanding of the data and the models of the data require visualization. Data analysis of this kind is practiced widely throughout academic scientific research, as well as widely throughout the public and private sectors.

## Teaching Format

This course will be practical, hands-on, and workshop based. For some topics, there will a very minimal amount of lecture style presentations, i.e., using slides or blackboard, to introduce and explain key concepts and theories, but almost all of our time will be spent doing data wrangling using R. Any code that the instructor produces during these sessions will be uploaded to a publicly available GitHub site after each session.

The course will take place online using Zoom. On each day, the live video broadcasts will occur between (UK local times) between 5pm-9pm.

All sessions will be video recorded and made available to all attendees as soon as possible.
  
Although not strictly required, using a large monitor or preferably even a second monitor will make the learning experience better, as you will be able to see my RStudio and your own RStudio simultaneously. 


## Assumed quantitative knowledge

We will assume familiarity with the most of basic concepts of descriptive and inferential statistics.

## Assumed computer background

Minimal prior experience with R and RStudio is required. Attendees should be familiar with some basic R syntax and commands, how to write code in the RStudio console and script editor, how to load up data from files, etc. 

## Equipment and software requirements

Attendees of the course will need to use RStudio. Most people will want to use their own computer on which they install the RStudio desktop software. This can be done Macs, Windows, and Linux, though not on tablets or other mobile devices. Instructions on how to install and configure all the required software, which is all free and open source, are provided [here](software.md). 
An alternative to using a local installation of RStudio is to use RStudio cloud (https://rstudio.cloud/). This is a free to use and full featured web based RStudio. It is not suitable for computationally intensive work but everything done in this class can be done using RStudio cloud.

You can also try this RStudio project running in mybinder:
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/mark-andrews/psyntur_in_binder/HEAD?urlpath=rstudio)


# Course programme 

## Day 1 

* Topic 1: *Wrangling with `dplyr` verbs*. For the remainder of Day 1, we will next cover the very powerful `dplyr` R package. This package supplies a number of so-called "verbs" --- `select`, `rename`, `slice`, `filter`, `mutate`, `arrange`, etc. --- each of which focuses on a key data manipulation tools, such as selecting or changing variables. All of these verbs can be chained together using "pipes" (represented by `%>%`). Together, these create powerful data wrangling pipelines that take raw data as input and return cleaned data as output. Here, we will also learn about the key concept of "tidy data", which is roughly where each row of a data frame is an observation and each column is a variable.

## Day 2

* Topic 2: *Summarizing data*. The `summarize` and `group_by` tools in `dplyr` can be used with great effect to summarize data using descriptive statistics. 
* Topic 3: *Pivoting data*. Sometimes we need to change data frames from "long" to "wide" formats. The R package `tidyr` provides the tools `pivot_longer` and `pivot_wider` for doing this.

## Day 3 

* Topic 4: *Merging and joining data frames*. There are multiple ways to combine data frames, with the simplest being "bind" operations, which are effectively horizontal or vertical concatenations. Much more powerful are the SQL like "join" operations. Here, we will consider the `inner_join`, `left_join`, `right_join`, `full_join` operations. In this section, we will also consider how to use `purrr` to read in and automatically merge large sets of files.
* Topic 5: *What is data visualization*. Data visualization is a means to explore and understand our data and should be a major part of any data analysis. Here, we briefly discuss why data visualization is so important and what the major principles behind it are. 
* Topic 6: *Introducing ggplot*. Though there are many options for visualization in R, ggplot is simply the best. Here, we briefly introduce the major principles behind how ggplot works, namely how it is a layered grammar of graphics.
* Topic 7: *Visualizing univariate data*. Here, we cover a set of major tools for visualizing distributions over single variables: histograms, density plots, barplots, Tukey boxplots. In each case, we will explore how to plot multiple groups of data simultaneously using different colours and also using facet plots.

## Day 4

* Topic 8: *Scatterplots*. Scatterplots and their variants are used to visualize bivariate data. Here, in addition to covering how to visualize multiple groups using colours and facets, we will also cover how to provide marginal plots on the scatterplots, labels to points, and how to obtain linear and nonlinear smoothing of the plots.
* Topic 9: *More plot types*. Having already covered the most widely used general purpose plots on Day 1, we now turn to cover a range of other major plot types: frequency polygons, area plots, line plots, uncertainty plots, violin plots, and geospatial mapping. Each of these are important and widely used types of plots, and knowing them will expand your repertoire.

## Day 5

* Topic 10: *Fine control of plots*. Thus far, we will have mostly used the default for the plot styles and layouts. Here, we will introduce how to modify things like the limits and scales on the axes, the positions and nature of the axis ticks, the colour palettes that are used, and the different types of ggplot themes that are available.
* Topic 11: *Plots for publications and presentations*: Thus far, we have primarily focused on data visualization as a means of interactively exploring data. Often, however, we also want to present our plots in, for example, published articles or in slide presentations. It is simple to save a plot in different file formats, and then insert them into a document. However, a much more efficient way of doing this is to use RMarkdown to run the R code and automatically insert the resulting figure into a, for example, Word document, pdf document, html page, etc. In addition, here we will also cover how to make labelled grids of subplots like those found in many scientific articles.


