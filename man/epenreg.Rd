\name{ecpreg}
\alias{epenreg}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Penalized-Regression-Based (PenReg) Integration of Base Learners for Ensemble Learning
}
\description{
This function applies Penalized Regression (Lasso and Ridge) to predictions from regression base learners to produce an ensemble prediction. Shrinkage parameter (\code{lambda}) is determined by minimizing the cross-validation error. The data partition for the integration phase does not have to be the same as the partition(s) used to generate the base learners. Functions from \pkg{EnsembleBase} are used for training and prediction of base learners. Also, base classes and generic methods of the same package are extended to support PenReg integration.
}
\usage{
epenreg(formula, data
  , baselearner.control=epenreg.baselearner.control()
  , integrator.control=epenreg.integrator.control()
  , ncores=1, filemethod=FALSE, print.level=1
)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{Formula expressing response variable and covariates.}
  \item{data}{Data frame containing the response variable and covariates.}
  \item{baselearner.control}{Control structure determining the base learners, their configurations, and data partitioning details. See \code{\link{epenreg.baselearner.control}}.}
  \item{integrator.control}{Control structure governing integrator behavior. See \code{\link{epenreg.integrator.control}}.}
  \item{ncores}{Number of cores used for parallel training of base learners.}
  \item{filemethod}{Boolean flag indicating whether or not to save estimation objects to disk or not. Using \code{filemethod=T} reduces RAM pressure.}
  \item{print.level}{Controlling verbosity level.}
}

\value{
An object of classes \code{epenreg} (if \code{filemethod==TRUE}, also has class of \code{epenreg.file}), a list with the following elements:
  \item{call}{Copy of function call.}
  \item{formula}{Copy of formula argument in function call.}
  \item{instance.list}{An object of class \code{\linkS4class{Instance.List}}, containing all permutations of base learner configurations and random data partitions generated in the body of the function.}
  \item{integrator.config}{Copy of configuration object passed to the integrator. Object of class \code{\linkS4class{Regression.Integrator.PenReg.SelMin.Config}}.}
  \item{method}{Integration method. Currently, only "default" is supported.}
  \item{est}{A list with these elements: 1) \code{baselearner.cv.batch}, an object of class \code{\linkS4class{Regression.CV.Batch.FitObj}} containing the fit object from CV batch training of base learners; 2) \code{integrator}, an object of class \code{\linkS4class{Regression.Integrator.PenReg.SelMin.FitObj}} containing the fit object returned by the integrator.}
  \item{y}{Copy of response variable vector.}
  \item{pred}{Within-sample prediction of the ensemble model.}
  \item{filemethod}{Copy of passed-in \code{filemethod} argument.}
}

\author{
Mansour T.A. Sharabiani, Alireza S. Mahani
}

\seealso{
\code{\link{epenreg.baselearner.control}}, \code{\link{epenreg.integrator.control}}, \code{\linkS4class{Instance.List}}, \code{\linkS4class{Regression.Integrator.PenReg.SelMin.Config}}, \code{\linkS4class{Regression.CV.Batch.FitObj}}, \code{\linkS4class{Regression.Batch.FitObj}}, \code{\linkS4class{Regression.Integrator.PenReg.SelMin.FitObj}}
}
\examples{
data(servo)
myformula <- class~motor+screw+pgain+vgain
perc.train <- 0.7
index.train <- sample(1:nrow(servo), size = round(perc.train*nrow(servo)))
data.train <- servo[index.train,]
data.predict <- servo[-index.train,]
## to run longer test using all 5 default regression base learners
## try: est <- epenreg(myformula, data.train, ncores=2)
est <- epenreg(myformula, data.train, ncores=2
  , baselearner.control=epenreg.baselearner.control(baselearners="knn"))
newpred <- predict(est, data.predict)
}
