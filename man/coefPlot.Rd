% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coefPlot.R
\name{coefPlot}
\alias{coefPlot}
\title{Plot model coefficients in \code{ggplot2}}
\usage{
coefPlot(data, varname, estimate, se, col.var = NULL, legend.title = "Legend")
}
\arguments{
\item{data}{Model output as dataframe, as returned by \code{tidy()} function (package \code{broom})
Must contain the following columns: variable name, estimate, etandard error}

\item{varname}{Column containing variable names}

\item{se}{Column with standard errors}

\item{col.var}{Variable to map colors onto (defaults to \code{varname})}

\item{legend.title}{Legend title. Default: "Legend"}
}
\description{
Plot model coefficients in \code{ggplot2}
}
