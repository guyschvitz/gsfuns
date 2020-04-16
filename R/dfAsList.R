##' Function to convert dataframe into list organized by grouping variable
##'
##' @param data Dataframe
##' @param groupingvar grouping variable
##' @return List with slots defined by grouping variable
##'
##' @export
dataAsList <- function(data, groupingvar){
  ids <- sort(unique(data[[groupingvar]]))
  temp.list <- vector('list', length(ids))
  for(i in seq_along(ids)){
    id <- ids[i]
    temp.list[[i]] <- data[data[[groupingvar]]==id,]
  }
  names(temp.list) <- paste(ids)
  return(temp.list)
}
