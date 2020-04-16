##' Plot missing values grouped by a variable
##'
##' Returns a tile plot with percentages of missing observations for each grouped variable
##'
##' @param data Dataframe
##' @param groupvar Variable to group missing observations by
##' @return \code{ggplot2} object
##'
##' @export
##'

plotGroupedNA <- function(data, groupvar){
  shareNA <- function(x){sum(is.na(x)) / length(x)}
  q.groupvar <- enquo(groupvar)
  na.share <- data %>%
    group_by(!!q.groupvar) %>%
    dplyr::summarize_all(shareNA) %>%
    melt(id.vars = quo_name(q.groupvar))
  p <- ggplot(na.share, aes(x=!!q.groupvar, y=variable, fill=value)) +
    theme_minimal() +
    geom_tile() +
    scale_fill_viridis(name = "% missing") +
    theme(axis.text.x = element_text(angle = 90),
          axis.ticks.x = element_blank())
  return(p)
}

