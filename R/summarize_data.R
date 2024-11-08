#' Summarize Data by Group
#'
#' This function takes a data frame, groups it by a specified column, and summarizes a numeric column by calculating the mean and standard deviation.
#'
#' @importFrom dplyr group_by summarise ungroup mutate
#' @importFrom magrittr %>%
#' @importFrom stats sd
#' @importFrom rlang .data
#' 
#' @param data A data frame to be summarized.
#' @param group_var A string specifying the column name to group by.
#' @param summary_var A string specifying the numeric column to summarize.
#' @param na.rm A logical value indicating whether to remove NA values. Defaults to TRUE.
#'
#' @return A data frame with the grouping variable and the calculated mean and standard deviation.
#'
#' @examples
#' # Basic usage
#' summarize_data(mtcars, "cyl", "mpg")
#' 
#' # Handling NA values
#' mtcars_na <- mtcars
#' mtcars_na$mpg[c(1, 5, 10)] <- NA
#' summarize_data(mtcars_na, "cyl", "mpg", na.rm = TRUE)
#' summarize_data(mtcars_na, "cyl", "mpg", na.rm = FALSE)
#'
#' @export
summarize_data <- function(data, group_var, summary_var, na.rm = TRUE) {
  # Check if group_var and summary_var are in the data frame
  if (!all(c(group_var, summary_var) %in% names(data))) {
    stop("Specified group_var or summary_var does not exist in the data frame.")
  }
  
  # Ensure that summary_var is numeric
  if (!is.numeric(data[[summary_var]])) {
    stop("summary_var must be a numeric column.")
  }
  
  # This pipeline processes 'data' to group and summarize specified variables
  data %>%
    # Group data by the specified 'group_var' column
    dplyr::group_by(.data[[group_var]]) %>%
    # Calculate summary statistics for the 'summary_var' column:
    # 'mean' - computes mean, ignoring NA values if 'na.rm' is TRUE
    # 'sd' - computes standard deviation, also ignoring NAs based on 'na.rm'
    dplyr::summarise(
      mean = mean(.data[[summary_var]], na.rm = na.rm),
      sd = stats::sd(.data[[summary_var]], na.rm = na.rm)
    ) %>%
    # Remove grouping structure from the data to return a regular data frame
    dplyr::ungroup()
}
