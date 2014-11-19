#' silva_NR_typestrains.
#' 
#' The Silva non-redundant typestrain database for the small
#' ribosomal subunit, release r119.
#' @source \url{http://www.arb-silva.de/}, downloaded 2014-10-10
#' @format A data frame with columns:
#' \describe{
#'  \item{Accession_Number}{The accession number of the organism.}
#'  \item{Sequence}{The nucleotide sequence.}
#' }
#' @examples
#'  silva_NR_typestrains
"silva_NR_typestrains"

#' silva_typestrainNR_taxonomy
#' 
#' Taxonomy data for the Silva non-redundant typestrain database for the small
#' ribosomal subunit, release r119.
#' @source \url{http://www.arb-silva.de/}, downloaded 2014-10-10
#' @format A data frame with columns:
#' \describe{
#'  \item{Accession_Number}{The accession number of the organism.}
#'  \item{Kingdom}{}
#'  \item{Phylum}{}
#'  \item{Class}{}
#'  \item{Order}{}
#'  \item{Family}{}
#'  \item{Genus}{}
#'  \item{Species}{}
#' }
#' @examples
#'  silva_typestrainNR_taxonomy
"silva_typestrainNR_taxonomy"

#' gates_tax
#' 
#' Taxonomy data for the Gates 1000 dataset according to NCBI.
#' @format A data frame with columns:
#' \describe{
#'  \item{OTU}{}
#'  \item{Kingdom}{}
#'  \item{Phylum}{}
#'  \item{Class}{}
#'  \item{Order}{}
#'  \item{Family}{}
#'  \item{Genus}{}
#'  \item{Species}{}
#' }
#' @examples
#'  gates_tax
"gates_tax"

#' gates_blastn
#' 
#' Blast results from Gates 1000 dataset.
#' @examples
#'  gates_blastn
"gates_blastn"