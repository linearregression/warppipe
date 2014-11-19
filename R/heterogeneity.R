heterogeneity_score <- function(vector){
  (length(unique(vector)) / length(vector)) - 1 / length(vector)
}

#' @importFrom dplyr group_by_ %>% summarise_each funs
groupwise_heterogeneity <- function(tbl, group_name){
  tbl %>%
    group_by_(group_name) %>%
    summarise_each(funs(heterogeneity_score))
}