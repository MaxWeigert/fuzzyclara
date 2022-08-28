test_that("clustering_local", { # clustering_local function

  data(USArrests)
  data <- USArrests %>% tibble::rownames_to_column(var = "Name")

  sample_med <- sample(x = 1:3, size = 20, replace = TRUE)
  sample_non_med <- sample(x = 1:nrow(data), size = 20, replace = TRUE)
  starting_medoids <- sample(x = data$Name[1:nrow(data)], size = 3,
                             replace = FALSE)
  sample <- list("medoids" = sample_med, "non_medoids" = sample_non_med,
                 "start" = starting_medoids)


  # fixed clustering
  cc_fixed <- clustering_local(data = data,
                                clusters = 3,
                                sample_local = sample,
                                metric = "euclidean",
                                type = "fixed",
                                verbose = 2)

  # check whole object
  expect_class(cc_fixed, "list")
  expect_length(cc_fixed, 5)

  # fuzzy clustering
  cc_fuzzy <- clustering_local(data = data,
                               clusters = 3,
                               sample_local = sample,
                               metric = "euclidean",
                               type = "fuzzy")

  # check whole object
  expect_class(cc_fuzzy, "list")
  expect_length(cc_fuzzy, 6)
  expect_identical(dim(cc_fuzzy$membership_scores), as.integer(c(nrow(data), 3)))


})

