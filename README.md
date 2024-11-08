
<!-- README.md is generated from README.Rmd. Please edit that file -->

# summarizeData

<!-- badges: start -->
<!-- badges: end -->

The goal of `summarizeData` is to offer a flexible function that
efficiently summarizes numeric data within dataframes. It allows users
to group data based on any specified column and computes essential
statistics, including mean and standard deviation, for each group. This
capability makes it an ideal tool for conducting quick and precise
statistical analyses across a variety of data types.

## Installation

You can install the `summarizeData` package from GitHub using the
`devtools` package:

``` r
# Install devtools if not already installed
install.packages("devtools")

# Install summarizeData from GitHub
devtools::install_github("stat545ubc-2024/summarizeData")
```

## Example

Below are examples illustrating how to use `summarizeData` to perform
statistical summaries on the `mtcars` dataset. These examples
demonstrate grouping and summarizing operations, along with handling
missing values effectively:

``` r
library(summarizeData)

# Summarize mpg by cyl in mtcars
summary_mtcars <- summarize_data(mtcars, "cyl", "mpg")
print(summary_mtcars)
#> # A tibble: 3 × 3
#>     cyl  mean    sd
#>   <dbl> <dbl> <dbl>
#> 1     4  26.7  4.51
#> 2     6  19.7  1.45
#> 3     8  15.1  2.56

# Handling NA values
mtcars_na <- mtcars
mtcars_na$mpg[c(1, 5, 10)] <- NA

# Summarize with na.rm = TRUE
summary_na_rm <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = TRUE)
print(summary_na_rm)
#> # A tibble: 3 × 3
#>     cyl  mean    sd
#>   <dbl> <dbl> <dbl>
#> 1     4  26.7  4.51
#> 2     6  19.6  1.64
#> 3     8  14.8  2.44

# Summarize with na.rm = FALSE
summary_na_not_rm <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = FALSE)
print(summary_na_not_rm)
#> # A tibble: 3 × 3
#>     cyl  mean    sd
#>   <dbl> <dbl> <dbl>
#> 1     4  26.7  4.51
#> 2     6  NA   NA   
#> 3     8  NA   NA
```
