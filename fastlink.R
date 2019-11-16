## Load the package and data
install.packages("fastLink")
library(fastLink)
data("samplematch")


matches.out <- fastLink(
  dfA = dfA, dfB = dfB, 
  varnames = c("firstname", "middlename", "lastname", "housenum", "streetname", "city", "birthyear"),
  stringdist.match = c("firstname", "middlename", "lastname", "streetname", "city"),
  partial.match = c("firstname", "lastname", "streetname")
)


View(matches.out)
View(matches.out$matches
     )

View(getMatches(dfA, dfB, matches.out))

summary(matches.out)
confusion(matches.out)
