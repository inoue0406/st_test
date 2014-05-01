#
# test of randomfields package
#

library(RandomFields)
library(RColorBrewer)

# 1. Run example of RFsimulate

# list oll available models
RFgetModelNames()

# 
RFoptions(seed=0)

## first let us look at the list of implemented models
RFgetModelNames(type="positive definite", domain="single variable",
                iso="isotropic") 

## our choice is the exponential model;
## the model includes nugget effect and the mean:
model <- RMexp(var=5, scale=10) + # with variance 4 and scale 10
  RMnugget(var=1) + # nugget
  RMtrend(mean=0.5) # and mean

## define the locations:
from <- 0
to <- 20
len <- if (interactive()) 200 else 2
x.seq <- seq(from, to, length=len) 
y.seq <- seq(from, to, length=len)

# simulation
simu <- RFsimulate(model, x=x.seq, y=y.seq, grid=TRUE)
plot(simu)




