# warppipe

## Quick Start
1 . Run Blast. Be sure to add the flag `-m 9`.
```
blastall -p blastn -i file.fasta -e 1 -v 10 -b 10 -o result.blastn -m 9
```

2 . Convert results and fasta file to tables.
```
blast_result <- read_blast_m9("result.blastn")
sequence_table <- seq_length_tbl("file.fasta")
```

3 . Create new filtered table.
```
warp_tbl(blast_result, sequence_table, n = 3, bit_score > 400)
```

## Installation
```
library(devtools)
devtools::install_github("seankross/warppipe")
```
