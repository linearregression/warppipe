#' Covert a data frame into a fasta file. The data frame must have sequence
#' descriptions in the first column and sequences in the second column.
#' 
#' @param tbl Data frame to convert.
#' @param file Name of fasta file to be created.
#' @param append Set to \code{TRUE} if you wish to append to a fasta file that already exists.
#' @export
#' @examples
#' \dontrun{
#' 
#' sequences <- seq_tbl("reads.fasta")
#' tbl_to_fasta(sequences[1:10,], "first_ten_reads.fasta")
#' 
#' }

tbl_to_fasta <- function(tbl, file, append = FALSE){
  # Check if file exists and warn user if append == FALSE
  if(file.exists(file) && !append){
    stop("File already exists. If you wish to append this file, set append = TRUE")
  }
  
  # For every row
  for(i in 1:length(tbl[[1]])){
    
    # Get sequence
    sequence <- tbl[i, 2]
    sequence <- as.character(sequence)
    
    # Find length of sequence
    seq_len <- nchar(sequence)
    
    # Split sequence into substrings
    seq_lines <- substring(sequence, seq(1, seq_len, 70), 
                           seq(70, seq_len + 70, 70))
    
    description <- paste0(">", as.character(tbl[i, 1]))
    
    # Check for problems
    
    # If the the last element of seq_lines contains 
    # the entire sequence, delete the last element
    if(identical(seq_lines[length(seq_lines)], sequence)){
      seq_lines <- seq_lines[-length(seq_lines)]
    }
    
    # If any of the strings in seq_lines are empty, remove them
    # from seq_lines
    if(any(seq_lines == "")){
      seq_lines <- seq_lines[-which(seq_lines == "")]
    }
    
    # Make sure things are formatted correctly
    if(any(nchar(seq_lines) > 70) || any(nchar(seq_lines) < 1)){
      message(paste("Error in", description))
      stop("Parsing Error")
    }
    
    cat(description, seq_lines, file = file, sep = "\n", append = TRUE)
  }
}