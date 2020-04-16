##' Plot model coefficients in \code{ggplot2}
##' @param data Model output as dataframe, as returned by \code{tidy()} function (package \code{broom})
##' Must contain the following columns: variable name, estimate, etandard error
##' @param varname Column containing variable names
##' @param se Column with standard errors
##' @param col.var Variable to map colors onto (defaults to \code{varname})
##' @param legend.title Legend title. Default: "Legend"
##'
##' @export
##'
coefPlot <- function(data, varname, estimate, se, col.var = NULL, legend.title = "Legend"){

  q.varname <- enquo(varname)
  q.estimate <- enquo(estimate)
  q.se <- enquo(se)
  if(is.null(col.var)){
    q.col.var <- enquo(varname)
  } else {
    q.col.var <- enquo(col.var)
  }

  # Specify the width of confidence intervals
  n.interval1 <- -qnorm((1 - 0.9)/2)  # 90% multiplier
  n.interval2 <- -qnorm((1 - 0.95)/2)  # 95% multiplier


  p <- ggplot(data, aes(x = !!q.varname, y = !!q.estimate, col = factor(!!q.col.var))) +
    coord_flip() +
    geom_hline(yintercept = 0, colour = gray(1/2), lty = 2) +
    geom_linerange(aes(x = term,
                       ymin = !!q.estimate - !!q.se*n.interval1,
                       ymax = !!q.estimate + !!q.se*n.interval1),
                   lwd = 1, position = position_dodge(width = 1/2)) +
    geom_pointrange(aes(x = !!q.varname, y = !!q.estimate,
                        ymin = !!q.estimate - !!q.se*n.interval2,
                        ymax = !!q.estimate + !!q.se*n.interval2),
                    lwd = 1/2, fatten=6,
                    position = position_dodge(width = 1/2),
                    shape = 20, fill = "WHITE") +
    scale_x_discrete(name = "Variable") +
    scale_y_continuous(name = "Coefficient and 95% Confidence Intervals") +
    scale_color_viridis(discrete=T, end = 0.9, option="C", name = legend.title) +
    theme_GS()

  return(p)

}

