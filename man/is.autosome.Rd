\name{is.autosome}
\alias{is.autosome}
\alias{is.chr.x}
\alias{is.chr.y}
\alias{is.chr.mt}

\title{ Autosomes and X, Y, MT chromosomes }

\description{
  Test if a chromosome id corresponds to an autosome or to X, Y, MT chromosomes
}
\usage{
  is.autosome(chr)
  is.chr.x(chr)
  is.chr.y(chr)
  is.chr.mt(chr)
}

\arguments{
  \item{chr}{ A vector if chromosome ids }
}

\details{
  These functions work by comparing the ids given in parameters with 
  the options \code{gaston.autosomes}, \code{gaston.chr.x}, \code{gaston.chr.y},
  \code{gaston.chr.mt}.

  For example, \code{is.autosome(chr)} is a short cut for 
  \code{chr \%in\% getOption("gaston.autosomes")}. It is used in particular
  in the default value of argument \code{which.snps} in \code{\link{GRM}} 
  and \code{\link{LD.thin}}.
}

\value{ 
  A vector of logicals.
}

\author{ Hervé Perdry }

\seealso{ \code{\link{GRM}}, \code{\link{LD.thin}} }

\keyword{ Chromosome }
