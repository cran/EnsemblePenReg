\name{epenreg.save}
\alias{epenreg.save}
\alias{epenreg.load}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Custom Functions for Disk I/O in \pkg{EnsemblePenReg} Package
}
\description{
These functions must be used in conjunction with \code{filemethod=TRUE} flag during the \code{epenreg} call.
}
\usage{
epenreg.save(obj, file)
epenreg.load(file)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{Object of classes \code{"\link{epenreg}"} and \code{"epenreg.file"}, usually the output of call to function \code{epenreg} with \code{filemethod} flag set to \code{TRUE}.}
  \item{file}{Filepath to where \code{obj} must be saved to / loaded from.}
}

\value{
Function \code{epenreg.load} returns the saved \code{obj}, with estimation files automatically copied to R temporary directory, and filepaths inside the \code{obj} fields updated to point to these new filepaths.
}

\author{
Mansour T.A. Sharabiani, Alireza S. Mahani
}


\seealso{
\code{\link{epenreg}}
}
\examples{
data(servo)
myformula <- class~motor+screw+pgain+vgain
perc.train <- 0.7
index.train <- sample(1:nrow(servo), size = round(perc.train*nrow(servo)))
data.train <- servo[index.train,]
data.predict <- servo[-index.train,]
est <- epenreg(myformula, data.train, ncores=2, filemethod=TRUE
  , baselearner.control=epenreg.baselearner.control(baselearners="knn"))
epenreg.save(est, "somefile")
rm(est) # alternatively, exit and re-launch R session
est.loaded <- epenreg.load("somefile")
newpred <- predict(est.loaded, data.predict)
}

