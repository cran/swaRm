#' @title Pairwise Distance Matrix
#' 
#' @description Given a set of locations, this function computes the distances 
#'  between each possible pair of locations.
#'  
#' @param x A vector of x (or longitude) coordinates. 
#' 
#' @param y A vector of y (or latitude) coordinates.
#' 
#' @param geo A logical value indicating whether the locations are defined by 
#'  geographic coordinates (pairs of longitude/latitude values). Default: FALSE. 
#'  
#' @return A square matrix representing pairwise distances between each possible 
#'  pair of locations.
#' 
#' @author Simon Garnier, \email{garnier@@njit.edu}
#' 
#' @seealso \code{\link{nn}}, \code{\link{nnd}}
#' 
#' @examples
#' x <- rnorm(25)
#' y <- rnorm(25, sd = 3)
#' pdist(x, y)
#' 
#' @export
pdist <- function(x, y, geo = FALSE) {
  if (length(x) != length(y)) 
    stop("x and y should have the same length.")
  
  if (!is.numeric(x) | !is.numeric(y))
    stop("x and y should be numeric.")
  
  if (geo) {
    l <- length(x)
    idx <- expand.grid(row = 1:l, col = 1:l)
    m1 <- cbind(x[idx$row], y[idx$row])
    m2 <- cbind(x[idx$col], y[idx$col])
    matrix(geosphere::distGeo(m1, m2), nrow = l, ncol = l)
  } else {
    as.matrix(stats::dist(cbind(x, y)))
  }
}


#' @title Nearest Neighbor
#'
#' @description Given the locations of different objects, this function 
#'  determines the identity of the nearest neighboring object to each object. 
#' 
#' @param x A vector of x (or longitude) coordinates. 
#' 
#' @param y A vector of y (or latitude) coordinates.
#' 
#' @param id A vector corresponding to the unique identities of each track.
#' 
#' @param geo A logical value indicating whether the locations are defined by 
#'  geographic coordinates (pairs of longitude/latitude values). Default: FALSE. 
#'  
#' @return A vector of the same length as x and y representing the identity of 
#'  the nearest neighboring object to each object. 
#' 
#' @author Simon Garnier, \email{garnier@@njit.edu}
#' 
#' @seealso \code{\link{nnd}}
#' 
#' @examples
#' x <- rnorm(25)
#' y <- rnorm(25, sd = 3)
#' id <- 1:25
#' nn(x, y, id)
#' 
#' @export
nn <- function(x, y, id, geo = FALSE) {
  if (!all(length(x) == c(length(y), length(id))))
    stop("x, y and id should have the same length.")
  
  if (!is.numeric(x) | !is.numeric(y))
    stop("x and y should be numeric.")
  
  d <- pdist(x, y, geo = geo)
  diag(d) <- NA
  d[is.na(x) | is.na(y), ] <- NA
  d[, is.na(x) | is.na(y)] <- NA
  
  idx <- apply(d, 2, 
               function(x) {
                 if (sum(is.na(x)) != length(x)) {
                   which(x == min(x, na.rm = TRUE))[1]
                 } else {
                   as.numeric(NA)
                 }
               })
  id[idx]
}


#' @title Nearest Neihgbor Distance
#'
#' @description Given the locations of different objects, this function 
#'  determines the distance of the nearest neighboring object to each object. 
#' 
#' @param x A vector of x (or longitude) coordinates. 
#' 
#' @param y A vector of y (or latitude) coordinates.
#' 
#' @param geo A logical value indicating whether the locations are defined by 
#'  geographic coordinates (pairs of longitude/latitude values). Default: FALSE. 
#'  
#' @return A vector of the same length as x and y representing the distance to 
#'  the nearest neighboring object for each object. 
#' 
#' @author Simon Garnier, \email{garnier@@njit.edu}
#' 
#' @seealso \code{\link{nn}}
#' 
#' @examples
#' x <- rnorm(25)
#' y <- rnorm(25, sd = 3)
#' id <- 1:25
#' nnd(x, y)
#' 
#' @export
nnd <- function(x, y, geo = FALSE) {
  if (length(x) != length(y)) 
    stop("x and y should have the same length.")
  
  if (!is.numeric(x) | !is.numeric(y))
    stop("x and y should be numeric.")
  
  d <- pdist(x, y, geo = geo)
  diag(d) <- NA
  d[is.na(x) | is.na(y), ] <- NA
  d[, is.na(x) | is.na(y)] <- NA
  
  apply(d, 2, 
        function(x) {
          if (sum(is.na(x)) != length(x)) {
            min(x, na.rm = TRUE)
          } else {
            as.numeric(NA)
          }
        })
}
