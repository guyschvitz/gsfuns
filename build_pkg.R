setwd("~/Documents/ICR/subversion/cshapes/cshapes")

devtools::document()
devtools::build_manual(getwd())
setwd("..")
devtools::install("cshapes")

cs <- cshp(as.Date("1980-01-01"))
cs  %>% dplyr::filter(gwcode == 565)

mapview(cs[,"gwcode"])

cshp()
