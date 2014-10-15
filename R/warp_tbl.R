#' Filter out promising blast hits given data frames created from other 
#' functions in this package.
#' 
#' @param blast A data frame converted from a blast result by using the function
#'  read_blast_m9().
#' @param tbl A data frame of a fasta file converted using seq_length_tbl(). 
#' @param n The top n hits to be returned.
#' @param ... Logical conditions to further filter the table. Combine conditions
#'  with \code{&}.
#' @export
#' @importFrom dplyr left_join mutate_ filter arrange_ desc group_by_ slice %>%
#' @examples
#' \dontrun{
#' 
#' # Setup 
#' blast_result <- read_blast_m9("result.blastn")
#' sequence_table <- seq_length_tbl("db.fasta")
#' 
#' # Get top hit for each query
#' warp_tbl(blast_result, sequence_table)
#' 
#' # Get top 5 hits for each query
#' warp_tbl(blast_result, sequence_table, n = 5)
#' 
#' # Get top 3 hits for each query where bit_score is greater than 400.
#' warp_tbl(blast_result, sequence_table, n = 3, bit_score > 400)
#' 
#' }

warp_tbl <- function(blast, tbl, n = 1, ...){
  blast %>%
    
    # Join sequence lengths
    left_join(tbl) %>%
    
    # Create new column: percent_total_identity
    mutate_(~(percent_total_identity = (alignment_length - mismatches) / sequence_length)) %>%
    
    # Filter further
    filter(...) %>%
    
    # List hits from highest to lowest
    arrange_(desc(~percent_total_identity)) %>%
    
    # Group hits by query id
    group_by_(~Query_id) %>%
    
    # Select top n hits
    slice(1:n)
}
