##' Save dataframe as csv while preserving all special characters
##'
##' Modified version of base R's \code{write.csv} function, ensures that
##' any special characters are preserved in output file
##'
##' @param data Dataframe
##' @param filename Output file path
##' @param ... Other options (see \code{write.csv})
##'
##' @export
##'

write.csv.utf8 <- function(data, filename, ...){
  data <- as.data.frame(data)
  con <- file(filename, "w")
  tryCatch({
    for (i in 1:ncol(data))
      data[,i] = iconv(data[,i], to = "UTF-8")
    writeChar(iconv("\ufeff", to = "UTF-8"), con, eos = NULL)
    write.csv(data, file = con, fileEncoding = "utf-8", ...)
  },finally = {close(con)})
}
