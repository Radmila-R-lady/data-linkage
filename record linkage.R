

# Install and load the package  -------------------------------------------------

library(RecordLinkage)
library(ggplot2)
library(dplyr)
#
data("RLdata500")
data(RLdata10000)
RLdata500[1:5, ]


# DEDUPLICATION  ----------------------------------------------------------------------

rpairs <- compare.dedup(RLdata500)
View(rpairs)
View(rpairs$pairs)

#Optional numerical vectors for identifying matches and non-matches.
#In a deduplication process, two records dataset[i,] and dataset[j,]
#are a true match if and only if identity[i,]==identity[j,]. 



rpairs <- compare.dedup(RLdata500,
                        identity = identity.RLdata500)

is.match<-rpairs$pairs


#let's visualise the duplicates before removing them 

duplicated_rows <- data_frame(duplicated = duplicated(is.match), row = 1:nrow(is.match)) %>%
  filter(is.match$is_match == 1)

nrow(duplicated_rows)
sum(duplicated(is.match))
ismatch[duplicated(ismatch)]

ggplot(duplicated_rows, aes(xintercept = row)) +
  geom_vline(aes(xintercept = row)) + # plot a black line for each duplicated row
  ggtitle("Indexes of duplicated rows") + # add a title
  coord_flip() + scale_x_reverse()+  #flip x & y axis and reverse the x axis
  ylab("Positions of duplicated records")+
  xlab("Row Index")+
  theme(plot.title = element_text(family = "", color="black", face="bold", size=18, hjust=0.5))

#uplicates as datasets
duplicates <- filter(is.match, is_match == 1)
View(duplicates)


rpairs1 <- compare.dedup(RLdata500,
                         blockfld = list(1, 5:7),
                         identity = identity.RLdata500)

is.match<-rpairs1$pairs
View(is.match)

rpairs <- compare.linkage(RLdata500,RLdata10000,exclude=c(2:5,7),identity1 = identity.RLdata500, identity2 = identity.RLdata10000)
View(rpairs$pairs)
data("RLdata10000")
View(identity.RLdata10000)
