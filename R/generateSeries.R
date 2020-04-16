##' Expand interval dataframe into series
##'
##' Expand dataframe containing an interval into series defined by step size
##'
##' @param data Dataframe
##' @param start Variable that defines starting point of interval / series
##' @param stop Variable that defines end point of interval / series
##' @param step Step size of output series. Default: 1
##' @param timeint Time increment, for dates only; Days, weeks, months, quarters or years. Default: days
##' @param varname Name of series variable. Default: "generate_series"
##' @return Dataframe containing series
##'
##' @export
##'
generateSeries <- function(data, start, stop, step=1, timeint = "day", varname = "generate_series"){
  if (inherits(data[,start], "Date")){
    step <- paste(step, timeint, sep=" ")
  } else {
  }
  data <- as.data.frame(data)
  data$id.temp <- seq_along(1:nrow(data))
  data.rest <- data[,!names(data)%in%c(start, stop)]
  data.out <- data.frame(var = unlist(Map(`seq`, data[,start], data[,stop], by=step)),
                       id.temp = rep(data[,"id.temp"], unlist(
                         Map(function(x,y){length(seq(x,y, by = step))},
                             data[,start], data[,stop]
                         )))
  )
  data.out <- merge(data.out, data.rest, by.x="id.temp", by.y="id.temp",
                  all.x=T)[, union(names(data.rest), names(data.out))]
  data.out <- data.out[,!names(data.out)%in%c("id.temp")]
  names(data.out)[ncol(data.out)] <- varname

  if (inherits(data[,start], "Date")){
    data.out[,var] <- as.Date(data.out[,var], origin = "1970-01-01")
  } else {
  }
  return(data.out)
}
