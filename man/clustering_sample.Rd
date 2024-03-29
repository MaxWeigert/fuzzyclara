% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clustering_sample.R
\name{clustering_sample}
\alias{clustering_sample}
\title{Perform clustering algorithm on a data sample}
\usage{
clustering_sample(
  data,
  sample_ids,
  dist,
  clusters = 5,
  metric = "euclidean",
  sample_size = NULL,
  type = "hard",
  seed = 1234,
  m = 1.5,
  verbose = 1,
  verbose_toLogFile = FALSE,
  build = FALSE,
  ...
)
}
\arguments{
\item{data}{data.frame to be clustered}

\item{sample_ids}{ids for the sample's observations}

\item{dist}{Dissimilarity matrix for subsample}

\item{clusters}{Number of clusters. Defaults to 5.}

\item{metric}{A character specifying a predefined dissimilarity metric (like
\code{"euclidean"} or \code{"manhattan"}) or a self-defined dissimilarity
function. Defaults to \code{"euclidean"}. Will be passed as argument
\code{method} to \code{\link[proxy]{dist}}, so check \code{?proxy::dist} for
full details.}

\item{sample_size}{Number of observations belonging to a sample}

\item{type}{One of \code{c("hard","fuzzy")}, specifying the type of
clustering to be performed.}

\item{seed}{Random number seed. Defaults to 1234.}

\item{m}{Fuzziness exponent (only for \code{type = "fuzzy"}), which has to be
a numeric of minimum 1. Defaults to 2.}

\item{verbose}{Can be set to integers between 0 and 2 to control the level of
detail of the printed diagnostic messages. Higher numbers lead to more
detailed messages. Defaults to 1.}

\item{verbose_toLogFile}{If TRUE, the diagnostic messages are printed to
a log file \code{clustering_progress.log}. Defaults to FALSE.}

\item{build}{Additional build algorithm to choose initial medoids (only
relevant for type = "fuzzy". Default FALSE.)}

\item{...}{Additional arguments passed to the main clustering algorithm
(\code{\link{pam}} or \code{\link[vegclust]{vegclust}})}
}
\value{
Clustering solution for data sample
}
\description{
Function to perform clara clustering algorithm in a hard or fuzzy way.
The function can either be performed using a common dissimilarity metric or
a self-defined distance function.
}
