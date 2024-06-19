library(reticulate)
sc = import("scanpy", convert=FALSE)
library(BiocFileCache)
ca = BiocFileCache()
pa = bfcquery(ca, "hlca.h5ad")$rpath
hl = sc$read_h5ad(pa, "r")
hl$X
hl$X[0] # a cell
hl$X[0]$sum() # total for the cell
hl$X[0:20]$getcol(3)$sum() # sum for 4th gene in first 21 cells
hl$X[0:20]$getcol(0)$sum() # sum for 1st gene in first 21 cells
hl$X[0:2000]$getcol(0)$sum() # sum for 1st gene in 2001 cells
hl$X[0:2000]$sum() # total for 2001 cells

