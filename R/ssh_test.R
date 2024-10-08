#' @title test explanatory power of spatial stratified heterogeneity
#' @description
#' Spatial stratified heterogeneity test based on geographical detector q value.
#' @note
#' This is a `C++` implementation of the `factor_detector` function in `gdverse` package.
#'
#' @param y Variable Y, continuous numeric vector.
#' @param hs Spatial partitioning or classification of each explanatory variable.
#' `factor`, `character`, `integer` or `data.frame`, `tibble`.
#'
#' @return A `tibble`
#' @export
#'
#' @examples
#' ssh_test(y = 1:7, hs = c('x',rep('y',3),rep('z',3)))
#'
ssh_test = \(y,hs){
  if (inherits(hs,"data.frame")) {
    hs = dplyr::mutate(hs,dplyr::across(dplyr::everything(),
                                        \(.x) as.integer(as.factor(.x))))
    qvs = purrr::map(hs,\(.h) GDFactorQ(y,.h))
    qv = purrr::map_dbl(qvs,\(.qv) .qv[[1]])
    pv = purrr::map_dbl(qvs,\(.qv) .qv[[2]])
    return(tibble::tibble(Variable = names(hs),
                          Qvalue = qv,
                          Pvalue = pv))
  } else {
    hs = as.integer(as.factor(hs))
    return(tibble::as_tibble(GDFactorQ(y,hs)))
  }
}
