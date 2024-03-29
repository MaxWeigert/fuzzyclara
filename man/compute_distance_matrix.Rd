% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clustering_sample.R
\name{compute_distance_matrix}
\alias{compute_distance_matrix}
\title{Compute the dissimilarity matrix for a data sample}
\usage{
compute_distance_matrix(data, sample_ids, metric = "euclidean")
}
\arguments{
\item{data}{Sample of data.frame to be clustered}

\item{sample_ids}{ids for the sample's observations}

\item{metric}{A character specifying a predefined dissimilarity metric (like
\code{"euclidean"} or \code{"manhattan"}) or a self-defined dissimilarity
function. Defaults to \code{"euclidean"}. Will be passed as argument
\code{method} to \code{\link[proxy]{dist}}, so check \code{?proxy::dist} for
full details.}
}
\value{
Dissimilarity matrix for data sample
}
\description{
Function to compute the dissimilarity matrix based on a specified metric
}
