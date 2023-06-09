% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shape.R
\name{stretch}
\alias{stretch}
\title{Stretching Direction}
\usage{
stretch(x, y)
}
\arguments{
\item{x}{A vector of x coordinates.}

\item{y}{A vector of y coordinates.}
}
\value{
A single numeric value corresponding to the angle (in radians) of the 
 main axis of the bivariate 95% confidence ellipse of the set.
}
\description{
Given a set of locations, this function approximates the 
 stretching direction of the set by calculating the angle of the main axis of 
 the bivariate 95% confidence ellipse of the set.
}
\examples{
x <- rnorm(25)
y <- rnorm(25, sd = 3)
stretch(x, y)

}
\seealso{
\code{\link{sphericity}}
}
\author{
Simon Garnier, \email{garnier@njit.edu}
}
