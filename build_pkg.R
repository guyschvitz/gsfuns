devtools::document()
devtools::build_manual(getwd())
setwd("..")
devtools::install("gsfuns")
