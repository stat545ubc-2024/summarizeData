
# summarizeData Package

## Description

`summarizeData` provides a flexible function to efficiently summarize
numeric data within dataframes. It groups data based on any specified
column and calculates essential statistics, such as mean and standard
deviation, for each group. This tool is ideal for quick and precise
statistical analyses across diverse data types.

## Installation

You can install the development version of `summarizeData` from GitHub
using the `devtools` package:

``` r
# Install devtools if not already installed
install.packages("devtools")

# Install summarizeData from GitHub
devtools::install_github("stat545ubc-2024/summarizeData")
```

## Usage

``` r
library(summarizeData)

# Summarize mpg by cyl in mtcars
summary_mtcars <- summarize_data(mtcars, "cyl", "mpg")
print(summary_mtcars)

# Handling NA values
mtcars_na <- mtcars
mtcars_na$mpg[c(1, 5, 10)] <- NA

# Summarize with na.rm = TRUE
summary_na_rm <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = TRUE)
print(summary_na_rm)

# Summarize with na.rm = FALSE
summary_na_not_rm <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = FALSE)
print(summary_na_not_rm)
```
