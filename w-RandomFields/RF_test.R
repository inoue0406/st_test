#
# test of randomfields package
#

library(RandomFields)
library(RColorBrewer)

# -------------------------------------
# 1. Run example of RFsimulate

# list oll available models
RFgetModelNames()

# Seed of Randomizatoin (if same, RFsimulate result will be the same)
RFoptions(seed=1)

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

# Conditional simulation

# first we simulate some random values at a
# 100 random locations:
n <- if (interactive()) 100 else 2
x <- runif(n=n, min=-1, max=1)
y <- runif(n=n, min=-1, max=1)
data <- RFsimulate(model = RMexp(), x=x, y=y, grid=FALSE)
plot(data)

# let simulate a field conditional on the above data
x.seq.cond <- y.seq.cond <- seq(-1.5, 1.5, length=n)
model <- RMexp()
cond <- RFsimulate(model = model, x=x.seq.cond, y=y.seq.cond,
                   grid=TRUE, data=data)

# write the result to file
#write.csv(cond,"tmp.csv")

# More examples
?RFsimulate.more.examples

# Ma-Stein RM
RFoptions(seed=0)
model <- RMmastein(RMgauss(), nu=1, delta=10)
x <- seq(0, 10, if (interactive()) 0.1 else 3)
plot(RFsimulate(model, x=x, y=x))

# Cox - Isham model
RFoptions(seed=0)
Dunit <- matrix(c(1,0,0,1),ncol=2) # assume no x-y correlation
model <- RMcoxisham(RMgauss(), mu=c(1,1), D=Dunit)
x <- seq(0, 10, if (interactive()) 0.3 else 1) 
# using MARGIN, 3d covariance model could be plotted
plot(model, ylim=c(0, 1), MARGIN=c(1,2),fixed.MARGIN=0,dim=3)
plot(model, ylim=c(0, 1), MARGIN=c(1,2),fixed.MARGIN=0.1,dim=3)
plot(model, ylim=c(0, 1), MARGIN=c(1,2),fixed.MARGIN=0.2,dim=3)
#
RFoptions(cPrintlevel=4) 
# (x,y,t) simulation not working well?
data <- RFsimulate(model, x=x, y=x,T=c(0,1,10))
plot(data)

