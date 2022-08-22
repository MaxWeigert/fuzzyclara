% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_select_cluster_numbers.R
\name{plot_cluster_numbers}
\alias{plot_cluster_numbers}
\title{Visualization of the selection criterion for different cluster numbers}
\usage{
plot_cluster_numbers(
  data,
  clusters_range = 2:5,
  metric = "euclidean",
  samples = 10,
  sample_size = NULL,
  type = "fixed",
  cores = 1,
  seed = 1234,
  m = 2,
  verbose = 1,
  return_results = FALSE,
  ...
)
}
\arguments{
\item{data}{data.frame to be clustered}

\item{clusters_range}{Evaluated range for the number of clusters. Defaults to
\code{2:5}.}

\item{metric}{A character specifying a predefined dissimilarity metric (like
\code{"euclidean"} or \code{"manhattan"}) or a self-defined dissimilarity
function. Defaults to \code{"euclidean"}. Will be passed as argument
\code{method} to \code{\link[proxy]{dist}}, so check \code{?proxy::dist} for
full details.}

\item{samples}{Number of subsamples}

\item{sample_size}{Number of observations belonging to a sample. If NULL
(default), the minimum of \code{nrow(data)} and \code{40 + clusters * 2} is
used as sample size.}

\item{type}{One of \code{c("fixed","fuzzy")}, specifying the type of
clustering to be performed.}

\item{cores}{Numbers of cores for computation. \code{cores > 1} implies
a parallel call. Defaults to 1.}

\item{seed}{Random number seed. Defaults to 1234.}

\item{m}{Fuzziness exponent (only for \code{type = "fuzzy"}), which has to be
a numeric of minimum 1. Defaults to 2.}

\item{verbose}{Can be set to integers between 0 and 2 to control the level of
detail of the printed diagnostic messages. Higher numbers lead to more detailed
messages. Defaults to 1.}

\item{return_results}{Indicator if clustering results ("fuzzyclara" objects)
should be returned as a list. Defaults to FALSE.}

\item{...}{Additional arguments passed to the main clustering algorithm call
with \code{\link{fuzzyclara}}.}
}
\value{
Object of class "fuzzyclara"
}
\description{
Function to provide graphical visualization for selecting the optimal number
of clusters
}