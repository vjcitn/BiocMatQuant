
#' obtain a SingleCellExperiment with a version of TENxPBMCData pbmc68k data
#' @import yesno
#' @import BiocFileCache
#' @import utils
#' @import HDF5Array
#' @note An 835MB zipfile holding the output of saveHDF5SummarizedExperiment is retrieved
#' from Open Storage Network and placed in cache.
#' colData labels are obtained with a SingleR run using the HumanPrimaryCellAtlasData
#' label.main.  
#' @param cache a cache like that defined by BiocFileCache::BiocFileCache()
#' @param targetfolder character(1) path, defaulting to `tempdir()`, where a serialized
#' SingleCellExperiment will be placed
#' @examples
#' tst = get68proc()
#' dir.exists(file.path(tempdir(), "p68_saved"))
#' tst
#' table(tst$labels)
#' rhdf5::h5ls(slot(DelayedArray::seed(assay(tst)), "filepath"))
#' @export
get68proc = function(cache=BiocFileCache::BiocFileCache(),
   targetfolder=tempdir()) {
 zippath = "https://mghp.osn.xsede.org/bir190004-bucket01/BiocMatrixGenerics/pbmc68kproc.zip"
 ent = BiocFileCache::bfcquery(cache, "pbmc68kproc.zip")
 if (nrow(ent)==0) {
   chkdl = yesno::yesno("This will download 840MB to your cache.  Proceed?")
   if (!chkdl) stop("download refused.")
   ent = BiocFileCache::bfcadd(cache, rname=zippath, action="copy")
   }
 refresh = BiocFileCache::bfcquery(cache, "pbmc68kproc.zip")
 nzip = nrow(refresh)
 ind = 1
 if (nzip==0) stop("could not acquire zipfile from cache")
 if (nzip > 1) {
   message("multiple pbmc68kproc entries found, using last")
   ind = nzip
   }
 entpath = refresh[ind,]$rpath
 secon = utils::unzip(entpath, exdir=targetfolder)
 HDF5Array::loadHDF5SummarizedExperiment(file.path(targetfolder, "p68_saved"))
}
