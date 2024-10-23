test_that("summarize_data works correctly with no NAs", {
  result <- summarize_data(mtcars, "cyl", "mpg")
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), length(unique(mtcars$cyl)))
  expect_true(all(c("mean", "sd") %in% names(result)))
})

test_that("summarize_data handles NA values correctly when na.rm = TRUE", {
  mtcars_na <- mtcars
  mtcars_na$mpg[1:3] <- NA
  result <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = TRUE)
  expect_true(all(!is.na(result$mean)))
  expect_true(all(!is.na(result$sd)))
})

test_that("summarize_data handles NA values correctly when na.rm = FALSE", {
  mtcars_na <- mtcars
  mtcars_na$mpg[1:3] <- NA
  result <- summarize_data(mtcars_na, "cyl", "mpg", na.rm = FALSE)
  expect_true(any(is.na(result$mean)))
  expect_true(any(is.na(result$sd)))
})

test_that("summarize_data throws an error for non-numeric summary_var", {
  mtcars_test <- mtcars %>%
    mutate(gear_factor = as.factor(gear))
  expect_error(summarize_data(mtcars_test, "cyl", "gear_factor"))
})

test_that("summarize_data throws an error when group_var does not exist", {
  expect_error(summarize_data(mtcars, "nonexistent_var", "mpg"))
})