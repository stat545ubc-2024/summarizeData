test_that("summarize_data works correctly with no NAs", {
  result <- summarize_data(mtcars, "cyl", "mpg")  # Perform the operation
  expect_true(is.data.frame(result))  # Validate the result is a dataframe
  expect_equal(nrow(result), length(unique(mtcars$cyl)))  # Compare row count to unique groups
  expect_true(all(c("mean", "sd") %in% names(result)))  # Ensure 'mean' and 'sd' are in column names
})

test_that("summarize_data handles NA values correctly when na.rm = TRUE", {
  mtcars_na <- mtcars
  mtcars_na$mpg[1:3] <- NA  # Introduce NA values into the dataset
  result <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = TRUE)  # Summarize data with NA removal
  expect_true(all(!is.na(result$mean)))  # Check for absence of NAs in 'mean'
  expect_true(all(!is.na(result$sd)))  # Check for absence of NAs in 'sd'
})

test_that("summarize_data handles NA values correctly when na.rm = FALSE", {
  mtcars_na <- mtcars
  mtcars_na$mpg[1:3] <- NA  # Introduce NA values into the dataset
  result <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = FALSE)  # Summarize data without removing NAs
  expect_true(any(is.na(result$mean)))  # Expect NAs to be present in 'mean'
  expect_true(any(is.na(result$sd)))  # Expect NAs to be present in 'sd'
})

test_that("summarize_data throws an error for non-numeric summary_var", {
  mtcars_test <- mtcars %>%
    mutate(gear_factor = as.factor(gear))  # Convert 'gear' to a factor to create a non-numeric summary variable
  expect_error(summarize_data(mtcars_test, "cyl", "gear_factor"))  # Expect error due to non-numeric data
})

test_that("summarize_data throws an error when group_var does not exist", {
  expect_error(summarize_data(mtcars, "nonexistent_var", "mpg"))  # Expect error due to non-existent group variable
})