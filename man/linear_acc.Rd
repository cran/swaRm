% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dist.R
\name{linear_acc}
\alias{linear_acc}
\alias{linAcc}
\title{Linear Accelerations}
\usage{
linear_acc(x, y, t, geo = FALSE)

linAcc(x, y, t, geo = FALSE)
}
\arguments{
\item{x}{A vector of x (or longitude) coordinates corresponding to a single 
trajectory.}

\item{y}{A vector of y (or latitude) coordinates corresponding to a single 
trajectory.}

\item{t}{A vector of timestamps corresponding to a single trajectory.}

\item{geo}{A logical value indicating whether the locations are defined by 
geographic coordinates (pairs of longitude/latitude values). Default: FALSE.}
}
\value{
A vector of the same length as x and y corresponding to the linear 
 accelerations between each pair of successive locations along the trajectory.
}
\description{
Given a set of locations defining a trajectory, this function 
 computes the linear accelerations between each pair of successive locations 
 along the trajectory.
}
\examples{
x <- rnorm(25)
y <- rnorm(25, sd = 3)
t <- as.POSIXct(1:25, origin = Sys.time())
linear_acc(x, y, t)

}
\seealso{
\code{\link{linear_speed}}, \code{\link{linear_dist}}
}
\author{
Simon Garnier, \email{garnier@njit.edu}
}
