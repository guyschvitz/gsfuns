# gsfuns
Useful R functions for data preparation and analysis

## Contents
- plotNA(): plot missing values for each variable in dataset
- plotGroupedNA(): plot missing values for each variable in dataset, grouped by another variable (e.g. year)
- dataAsList(): convert dataframe to list, grouped by variable
- generateSeries(): mimics PostgreSQL's generate_series function on R dataframes (see [here](https://www.postgresql.org/docs/9.1/functions-srf.html))
- coeftestCluster(): get single or double clustered standard errors or variance-covariance matrix after glm or lm (slightly adjusted code taken from [iangow](https://github.com/iangow-public/acct_data/blob/master/code/cluster2.R))
- coefPlot(): plot tidy regression coefficients and standard errors
- theme_GS(): minimal ggplot theme

## Installation
To install the package, run the following code in R

```r
devtools::install_github("guyschvitz/gsfuns")
```

## Usage
