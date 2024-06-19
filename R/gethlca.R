

#' obtain a SingleCellExperiment with a version of Human Lung Cell Atlas
#' @import yesno
#' @import BiocFileCache
#' @import SingleCellExperiment
#' @import utils
#' @import HDF5Array
#' @note A 21GB H5AD object is retrieved
#' from Open Storage Network and placed in cache.  HDF5Array::H5ADMatrix
#' is then used to acquire a reference that is returned.
#' @param cache a cache like that defined by BiocFileCache::BiocFileCache()
#' SingleCellExperiment will be placed
#' @return Instance of HDF5Array::H5ADMatrix, which has more than 2^31-1
#' non-zero elements, and may be difficult to manipulate.
#' @examples
#' if (interactive()) {   # not for github actions, yet
#'  x = gethlca_h5admat()
#'  try(x[1:4,1:5])
#' }
#' @export
gethlca_h5admat = function(cache=BiocFileCache::BiocFileCache()) {
 h5adpath = "https://mghp.osn.xsede.org/bir190004-bucket01/BiocHLCA/hlca.h5ad"
 ent = BiocFileCache::bfcquery(cache, "hlca.h5ad")
 if (nrow(ent)==0) {
   if (interactive()) {
     chkdl = yesno::yesno("This will download a 21GB h5ad to your cache.  Proceed?")
     if (!chkdl) stop("download refused.")
     }
   ent = BiocFileCache::bfcadd(cache, rname=h5adpath, action="copy")
   }
 refresh = BiocFileCache::bfcquery(cache, "hlca.h5ad")
 nzip = nrow(refresh)
 ind = 1
 if (nzip==0) stop("could not acquire h5ad from cache")
 if (nzip > 1) {
   message("multiple hlca entries found, using last")
   ind = nzip
   }
 entpath = refresh[ind,]$rpath
 HDF5Array::H5ADMatrix(entpath)
}
