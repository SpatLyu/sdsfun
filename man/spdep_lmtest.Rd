% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spdep_helpers.R
\name{spdep_lmtest}
\alias{spdep_lmtest}
\title{spatial linear models selection}
\usage{
spdep_lmtest(formula, data, listw = NULL)
}
\arguments{
\item{formula}{A formula for linear regression model.}

\item{data}{An \code{sf} object of observation data.}

\item{listw}{(optional) A listw. See \code{spdep::mat2listw()} and \code{spdep::nb2listw()}
for details.}
}
\value{
A list
}
\description{
spatial linear models selection
}
\examples{
boston_506 = sf::read_sf(system.file("shapes/boston_tracts.shp", package = "spData"))
spdep_lmtest(log(median) ~ CRIM + ZN + INDUS + CHAS, boston_506)

}
