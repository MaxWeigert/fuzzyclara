% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fuzzyclara.R
\name{clara_boxplot}
\alias{clara_boxplot}
\title{Plot function boxplot}
\usage{
clara_boxplot(
  x,
  data,
  variable,
  group_by = NULL,
  na.omit = FALSE,
  membership_threshold = 0
)
}
\arguments{
\item{x}{An object of class "fuzzyclara"}

\item{data}{Prepared data.frame (contains cluster variable, observations are
already filtered by threshold (fuzzy))}

\item{variable}{Name of variable to plot}

\item{group_by}{Optional grouping variable}

\item{na.omit}{Should missing values be excluded for plotting? Defaults to
FALSE.}

\item{membership_threshold}{Threshold for fuzzy clustering observations to
be plotted. Must be a number between 0 and 1. Defaults to 0.}
}
\value{
boxplot
}
\description{
Function to plot a boxplot
}
