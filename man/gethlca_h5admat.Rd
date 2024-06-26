% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gethlca.R
\name{gethlca_h5admat}
\alias{gethlca_h5admat}
\title{obtain a SingleCellExperiment with a version of Human Lung Cell Atlas}
\usage{
gethlca_h5admat(cache = BiocFileCache::BiocFileCache())
}
\arguments{
\item{cache}{a cache like that defined by BiocFileCache::BiocFileCache()
SingleCellExperiment will be placed}
}
\value{
Instance of HDF5Array::H5ADMatrix, which has more than 2^31-1
non-zero elements, and may be difficult to manipulate.
}
\description{
obtain a SingleCellExperiment with a version of Human Lung Cell Atlas
}
\note{
A 21GB H5AD object is retrieved
from Open Storage Network and placed in cache.  HDF5Array::H5ADMatrix
is then used to acquire a reference that is returned.
}
\examples{
if (interactive()) {   # not for github actions, yet
 x = gethlca_h5admat()
 try(x[1:4,1:5])
}
}
