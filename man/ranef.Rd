\name{ranef}
\alias{ranef}
\alias{ranef.merMod}
\title{Extract the modes of the random effects}
\usage{
  \method{ranef}{merMod} (object, condVar = FALSE,
    drop = FALSE, whichel = names(ans), postVar=FALSE, ...)
}
\arguments{
  \item{object}{an object of a class of fitted models with
  random effects, typically an
  \code{"\linkS4class{merMod}"} object.}

  \item{condVar}{an optional logical argument indicating if
  the conditional variance-covariance matrices of the random effects
  should be added as an attribute.}

  \item{drop}{an optional logical argument indicating
  components of the return value that would be data frames
  with a single column, usually a column called
  \sQuote{\code{(Intercept)}}, should be returned as named
  vectors.}

  \item{whichel}{an optional character vector of names of
  grouping factors for which the random effects should be
  returned.  Defaults to all the grouping factors.}

  \item{postVar}{a (deprecated) synonym for \code{condVar}}

  \item{\dots}{some methods for this generic function
  require additional arguments.}
}
\value{
  A list of data frames, one for each grouping factor for
  the random effects.  The number of rows in the data frame
  is the number of levels of the grouping factor.  The
  number of columns is the dimension of the random effect
  associated with each level of the factor.

  If \code{condVar} is \code{TRUE} each of the data frames
  has an attribute called \code{"postVar"} which is a
  three-dimensional array with symmetric faces. (The name
  of this attribute is a historical artifact.)

  When \code{drop} is \code{TRUE} any components that would
  be data frames of a single column are converted to named
  numeric vectors.
}
\description{
  A generic function to extract the conditional modes of
  the random effects from a fitted model object.  For
  linear mixed models the conditional modes of the random
  effects are also the conditional means.
}
\details{
  If grouping factor i has k levels and j random effects
  per level the ith component of the list returned by
  \code{ranef} is a data frame with k rows and j columns.
  If \code{condVar} is \code{TRUE} the \code{"postVar"}
  attribute is an array of dimension j by j by k.  The kth
  face of this array is a positive definite symmetric j by
  j matrix.  If there is only one grouping factor in the
  model the variance-covariance matrix for the entire
  random effects vector, conditional on the estimates of
  the model parameters and on the data will be block
  diagonal and this j by j matrix is the kth diagonal
  block.  With multiple grouping factors the faces of the
  \code{"postVar"} attributes are still the diagonal blocks
  of this conditional variance-covariance matrix but the
  matrix itself is no longer block diagonal.
}
\note{
  To produce a \dQuote{caterpillar plot} of the random
  effects apply \code{\link[lattice:xyplot]{dotplot}} to
  the result of a call to \code{ranef} with \code{condVar =
  TRUE}.
}
\examples{
require(lattice)
fm1 <- lmer(Reaction ~ Days + (Days|Subject), sleepstudy)
fm2 <- lmer(Reaction ~ Days + (1|Subject) + (0+Days|Subject), sleepstudy)
fm3 <- lmer(diameter ~ (1|plate) + (1|sample), Penicillin)
ranef(fm1)
str(rr1 <- ranef(fm1, condVar = TRUE))
dotplot(rr1)  ## default
## specify free scales in order to make Day effects more visible
dotplot(rr1,scales = list(x = list(relation = 'free')))[["Subject"]]
if(FALSE) { ##-- condVar=TRUE is not yet implemented for multiple terms -- FIXME
str(ranef(fm2, condVar = TRUE))
}
op <- options(digits = 4)
ranef(fm3, drop = TRUE)
options(op)
}
\keyword{methods}
\keyword{models}

