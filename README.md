# gsfuns
R functions for data preparation and analysis

*Contents*
- plotNA: plot missing values in dataset
- plotGroupedNA: plot missing values in dataset, grouped by variable (e.g. year)
- dataAsList: convert dataframe to list, grouped by variable
- generateSeries: mimics PostgreSQL's generate_series function on R dataframes
- coeftestCluster: get clustered standard errors or variance-covariance matrix after glm or lm (slightly adjusted code taken from https://github.com/iangow-public/acct_data/blob/master/code/cluster2.R)
- coefPlot: plot tidy regression coefficients and standard errors
- theme_GS: minimal ggplot template
