# Create Silva typestrain database from fasta file
# Retrieve a fasta file from http://www.arb-silva.de/search/
# strain: [T]
# Sequences occur in: [x]Ref(NR)
# Taxonomy: Silva Ref NR

library(warppipe)
library(dplyr)
library(stringr)

silva_NR_typestrains <- seq_tbl("data-raw/silva_SSUr119_silvaRefNR.fasta")
silva_NR_typestrains <- mutate(silva_NR_typestrains, str_match(Description, "[A-Z0-9.]+"))
colnames(silva_NR_typestrains)[3] <- "Accession_Number"
silva_NR_typestrains <- select(silva_NR_typestrains, Accession_Number, Sequence)

save(silva_NR_typestrains, file="data/silva_ref_nr.rda", compress = "xz")
write.csv(silva_NR_typestrains, "data-tidy/silva_ref_nr.csv", row.names = FALSE)
