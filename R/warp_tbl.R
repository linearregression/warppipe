#' Given a data frame and two column names, this function returns a data frame
#' where groupings of the first variable contain differences with respect to the
#' second variable.
#' 
#' @param tbl A data frame with at least two columns
#' @param grouping The column name specifying how to group the rows.
#' @param warp_by The column name specifying the differences within groups to look for.
#' @export
#' @importFrom dplyr %>%
#' @examples
#' \dontrun{
#' 
#' fruit_prices <- data.frame(Fruit = c("Apple", "Apple", "Orange", "Orange", "Pear", "Pear"),
#'                            Price = c(1.2, 1.3, 1.1, 1.1, 1.4, 1.1))
#' warp_tbl(fruit_prices, "Fruit", "Price")
#' warp_tbl(fruit_prices, "Price", "Fruit")
#' 
#' }

warp_tbl <- function(tbl, grouping, warp_by){
  warped_tbl <- groupwise_heterogeneity(tbl, grouping)
  warped_tbl <- warped_tbl %>% s_filter(paste0(warp_by, ">0"))
  groups_to_filter_on <- as.vector(unlist(warped_tbl[grouping]))
  tbl %>% 
    s_filter(paste0(grouping, " %in% ", make_text_vector(groups_to_filter_on))) %>%
    s_group_by(grouping) %>%
    s_arrange(paste0("desc(", grouping, ")"))
}

make_text_vector <- function(vector){
  characterize <- paste0("'", vector, "'")
  cs_vector <- paste(characterize, collapse = ",")
  paste0("c(", cs_vector, ")")
}

# Helper functions that allow string arguments for  dplyr's data modification
# functions like arrange, select etc. 
# Author: Sebastian Kranz
# Source: https://gist.github.com/skranz/9681509

# Modified version of dplyr's filter that uses string arguments
s_filter = function(.data, ...) {
  eval.string.dplyr(.data,"filter", ...)
}

# Modified version of dplyr's group_by that uses string arguments
s_group_by = function(.data, ...) {
  eval.string.dplyr(.data,"group_by", ...)
}

# Modified version of dplyr's arrange that uses string arguments
s_arrange = function(.data, ...) {
  eval.string.dplyr(.data,"arrange", ...)
}

# Internal function used by s_filter, s_select etc.
eval.string.dplyr = function(.data, .fun.name, ...) {
  args = list(...)
  args = unlist(args)
  code = paste0(.fun.name,"(.data,", paste0(args, collapse=","), ")")
  df = eval(parse(text=code,srcfile=NULL))
  df  
}