#' Perform clustering
#'
#' Function to perform a cluster analysis in a fixed or fuzzy way. The
#' function can either be performed using a common dissimilarity metric or
#' a self-defined distance function.
#'
#' If the clustering is run on mulitple cores, the verbose messages are printed
#' in a file \code{clustering_progress.log} (if \code{verbose > 0}).
#'
#' @param data data.frame to be clustered
#' @param clusters Number of clusters. Defaults to 5.
#' @param metric A character specifying a predefined dissimilarity metric (like
#' \code{"euclidean"} or \code{"manhattan"}) or a self-defined dissimilarity
#' function. Defaults to \code{"euclidean"}. Will be passed as argument
#' \code{method} to \code{\link[proxy]{dist}}, so check \code{?proxy::dist} for
#' full details.
#' @param algorithm One of \code{c("clara","clarans")}
#' @param samples Number of subsamples (only if \code{algorithm = "clara"})
#' @param sample_size Number of observations belonging to a sample. If NULL
#' (default), the minimum of \code{nrow(data)} and \code{40 + clusters * 2} is
#' used as sample size. (only if \code{algorithm = "clara"})
#' @param max_neighbors Maximum number of randomized medoid searches with each
#' cluster (only if \code{algorithm = "clarans"})
#' @param num_local Number of clustering iterations (only if
#' \code{algorithm = "clarans"})
#' @param type One of \code{c("fixed","fuzzy")}, specifying the type of
#' clustering to be performed.
#' @param m Fuzziness exponent (only for \code{type = "fuzzy"}), which has to be
#' a numeric of minimum 1. Defaults to 2.
#' @param cores Numbers of cores for computation. \code{cores > 1} implies
#' a parallel call. Defaults to 1.
#' @param seed Random number seed. Defaults to 1234.
#' @param verbose Can be set to integers between 0 and 2 to control the level of
#' detail of the printed diagnostic messages. Higher numbers lead to more
#' detailed messages. Defaults to 1.
#' @param scale Scale numeric variables before distance matrix calculation?
#' Default TRUE
#' @param build Additional build algorithm to choose initial medoids (only
#' relevant for type = "fuzzy". Default FALSE.)
#' @param ... Additional arguments passed to the main clustering algorithm and
#' to proxy::dist for the calculation of the distance matrix
#' (\code{\link{pam}} or \code{\link[vegclust]{vegclust}})
#'
#' @return Object of class "fuzzyclara"
#'
#' @import cluster parallel checkmate tibble dplyr tidyselect
#' @export
#'
#' @references TODO add CLARA and CLARANS papers, and maybe something else?
#'
fuzzyclara <- function(data, clusters = 5, metric = "euclidean",
                       algorithm = "clara", samples = 10, sample_size = NULL,
                       max_neighbors = 100, num_local = 10, type = "fixed",
                       cores = 1, seed = 1234, m = 2, verbose = 1, # TODO alle seeds auf default 42 aendern? Waere etwas interessanter als 1234. ;)
                       scale = TRUE, build = FALSE, ...) {

  checkmate::assert(checkmate::check_data_frame(data),
                    checkmate::check_matrix(data), combine = "or") # TODO should a matrix be possible here? The documentation above only talks about a data.frame.
  checkmate::assert_numeric(clusters, lower = 1, upper = nrow(data))
  checkmate::assert_numeric(samples, lower = 1)
  checkmate::assert_numeric(sample_size, lower = clusters, null.ok = TRUE)
  checkmate::assert_numeric(max_neighbors, lower = 1)
  checkmate::assert_numeric(num_local, lower = 1)
  checkmate::assert_choice(algorithm, choices = c("clara", "clarans"))
  checkmate::assert_choice(type, choices = c("fixed", "fuzzy"))
  checkmate::assert_number(m, lower = 1)
  checkmate::assert_number(cores, lower = 1)
  checkmate::assert_number(seed)
  checkmate::assert_choice(verbose, choices = 0:2)
  checkmate::assert_logical(scale, len = 1)
  checkmate::assert_logical(build, len = 1)


  # pam requires the number of clusters to be smaller than the number of
  # observations -> another check of sample_size
  if(type == "fixed" | m == 1 | clusters == 1){
    checkmate::assert_numeric(x = sample_size, lower = clusters + 1,
                              null.ok = TRUE)
  }

  # Convert data into data.frame if necessary:
  if (!("data.frame" %in% class(data))) {
    data <- as.data.frame(data)
  }

  # Extract name of metric:
  if (class(metric) == "function") {
    name_metric <- deparse(substitute(metric))
  }
  else {
    name_metric <- metric
  }

  if(scale == TRUE){
    # optional: Scaling of numerical (and ordinal) variables:
    ind <- unlist(lapply(data, is.numeric), use.names = TRUE)
    for (i in ind) {
      data[, ind] <- scale(data[, ind])
    }
  }

  # Choice of clustering algorithm:
  # clara algorithm:
  if (algorithm == "clara") {
    result <- clustering_clara(data, clusters = clusters, metric = metric,
                               samples = samples, sample_size = sample_size,
                               type = type, cores = cores, seed = seed, m = m,
                               verbose = verbose, build = build, ...)
  }
  if (algorithm == "clarans") {
    result <- clustering_clarans(data, clusters = clusters, metric = metric,
                                 max_neighbors = max_neighbors,
                                 num_local = num_local, type = type,
                                 cores = cores, seed = seed, m = m,
                                 verbose = verbose, ...)
  }

  # Return of clustering solution:
  return(result)
}