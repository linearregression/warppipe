#' Convert a blast result obtained while using the -m 9 flag with blastall 
#' into a data frame.
#' 
#' @param path The path to the fasta file.
#' @export
#' @examples
#' \dontrun{
#' 
#' read_blast_m9("path/to/file.blastn")
#' 
#' }

read_blast_m9 <- function(path){
  df <- read.delim(path, header = FALSE, comment.char = "#")
  colnames(df) <- c("Query_id", "Subject_id", "percent_identity", 
                    "alignment_length", "mismatches", "gap_openings", "q_start",
                    "q_end", "s_start", "s_end", "e_value", "bit_score")
  df
}
