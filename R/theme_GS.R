##' Custom ggplot theme using minimal elements
##'
##' Theme uses white background, minimal necessary elements,
##' black axis text and slightly larger font sizes for axis text and titles
##' than the default.
##'
##' @export
##'
theme_GS <- function(){
  theme(panel.background = element_rect(fill = NA),
        panel.border = element_rect(fill = NA, color = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks = element_line(color = "gray5"),
        axis.text = element_text(color = "black", size = 10),
        axis.title = element_text(color = "black", size = 12),
        strip.background = element_rect(color = "black"),
        legend.background = element_rect(fill = NA))}
