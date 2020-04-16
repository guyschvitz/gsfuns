##' Cluster standard errors on one or two variables
##'
##' Slightly modified function to cluster standard errors from \code{glm} or \code{lm} models.
##' Taken from: \url{https://github.com/iangow-public/acct_data/blob/master/code/cluster2.R}
##' @param data Dataframe used to estimate model
##' @param mod Model estimated using \code{glm} or \code{lm}
##' @param namevec Names of model variables
##' @param cluster1 Clustering variable
##' @param cluster2 Second clustering variable (optional)
##' @param coeftest Boolean. Return \code{coeftest} object (TRUE) or clustered variance-covariance matrix?
##' @return \code{coeftest} object or a clustered variance-covariance matrix
##'
##' @export
##'
coeftestCluster <- function(data, mod, namevec, cluster1, cluster2=NULL, coeftest = T) {

  data <- as.data.frame(data)
  # Calculation shared by covariance estimates
  est.fun <- estfun(mod)

  # Need to identify observations used in the regression (i.e.,
  # non-missing) values, as the cluster vectors come from the full
  # data set and may not be in the regression model.
  # I use complete.cases following a suggestion from
  # Francois Cocquemas <francois.cocquemas@gmail.com>
  inc.obs <- complete.cases(data[,namevec])

  # Shared data for degrees-of-freedom corrections
  N  <- dim(mod$model)[1]
  NROW <- NROW(est.fun)
  K  <- mod$rank

  # Calculate the sandwich covariance estimate
  cov <- function(cluster) {
    cluster <- factor(cluster)

    # Calculate the "meat" of the sandwich estimators
    u <- apply(est.fun, 2, function(x) tapply(x, cluster, sum))
    meat <- crossprod(u)/N

    # Calculations for degrees-of-freedom corrections, followed
    # by calculation of the variance-covariance estimate.
    # NOTE: NROW/N is a kluge to address the fact that sandwich uses the
    # wrong number of rows (includes rows omitted from the regression).
    M <- length(levels(cluster))
    dfc <- M/(M-1) * (N-1)/(N-K)
    dfc * NROW/N * sandwich(mod, meat=meat)
  }

  # Calculate the covariance matrix estimate for the first cluster.
  cluster1 <- data[inc.obs,cluster1]
  cov1  <- cov(cluster1)

  if(is.null(cluster2)) {
    # If only one cluster supplied, return single cluster
    # results
    return(coeftest(mod, cov1))
  } else {
    # Otherwise do the calculations for the second cluster
    # and the "intersection" cluster.
    cluster2 <- data[inc.obs,cluster2]
    cluster12 <- paste(cluster1,cluster2, sep="")

    # Calculate the covariance matrices for cluster2, the "intersection"
    # cluster, then then put all the pieces together.
    cov2   <- cov(cluster2)
    cov12  <- cov(cluster12)
    covMCL <- (cov1 + cov2 - cov12)

    # Return the output of coeftest using two-way cluster-robust
    # standard errors.
    if(coeftest == TRUE){
      return(coeftest(mod, covMCL))
    } else {
      return(covMCL)
    }
  }
}

## Support old function name
coeftest.cluster <- coeftestCluster
