#' Convert a fasta file into a data frame containing the decription of each
#' sequence in the first column and the length of that sequence in the second
#' column.
#' 
#' @param path The path to the fasta file.
#' @param description A regular expression indicating which lines contain sequence descriptions.
#' @param comment A regular expression indicating which lines contain comments.
#' @export
#' @importFrom stringr str_trim str_length
#' @examples
#' \dontrun{
#' 
#' # Normal use
#' seq_length_tbl("path/to/file.fasta")
#' 
#' # Comments are lines where number sign is first character
#' seq_length_tbl("path/to/file.fasta", comment = "^#")
#' 
#' }

seq_length_tbl <- function(path, description = "^>", comment = "^;"){
  # Read fasta file
  fasta_file <- readLines(path)
  
  # Trim whitespace
  fasta_file <- str_trim(fasta_file)
  
  # Remove description lines
  fasta_file <- fasta_file[-grep(comment, fasta_file)]
  
  # Find lines with descriptions
  description_lines <- grep(description, fasta_file)
  
  sections <- list()
  
  # Set last description "fencepost" as the last line plus 1
  fencepost_lines <- c(description_lines, length(fasta_file) + 1)
  
  for(i in 1:(length(fencepost_lines) - 1)){
    sections[[i]] <- seq(fencepost_lines[i] + 1, fencepost_lines[i + 1] - 1)
  }
  
  len <- lapply(sections, 
    function(x, file = fasta_file){
      sum(str_length(file[x]))
    })
  len <- unlist(len)
  
  # Create data frame
  data.frame(Description = sub(description, "", fasta_file[description_lines]),
             sequence_length = len)
}