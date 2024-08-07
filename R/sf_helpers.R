#' @title sf object geometry column name
#' @description
#' Get the geometry column name of an sf object
#'
#' @param sfj An `sf` object.
#'
#' @return A character.
#' @export
#'
#' @examples
#' library(sf)
#' snnu = read_sf(system.file('extdata/snnu.geojson',package = 'sdsfun'))
#' sf_geometry_name(snnu)
#'
sf_geometry_name = \(sfj){
  gname = attr(sfj, "sf_column")
  return(gname)
}

#' @title sf object geometry type
#' @description
#' Get the geometry type of an sf object
#'
#' @param sfj An `sf` object.
#'
#' @return A lowercase character vector
#' @export
#'
#' @examples
#' library(sf)
#' snnu = read_sf(system.file('extdata/snnu.geojson',package = 'sdsfun'))
#' sf_geometry_type(snnu)
#'
sf_geometry_type = \(sfj){
  sfj_type = sfj %>%
    sf::st_geometry_type() %>%
    as.character() %>%
    unique()
  return(tolower(sfj_type))
}

#' @title generates voronoi diagram
#' @description
#' Generates Voronoi diagram (Thiessen polygons) for sf object
#' @note
#' Only sf objects of (multi-)point type are supported to generate voronoi diagram
#' and the returned result includes only the geometry column.
#'
#' @param sfj An `sf` object.
#'
#' @return An `sf` object of polygon geometry type.
#' @export
#'
#' @examples
#' library(sf)
#' pts = read_sf(system.file('extdata/pts.gpkg',package = 'sdsfun'))
#' pts_v = sf_voronoi_diagram(pts)
#'
#' library(ggplot2)
#' ggplot() +
#'   geom_sf(data = pts_v, color = 'red',
#'           fill = 'transparent') +
#'   geom_sf(data = pts, color = 'blue', size = 1.25) +
#'   theme_void()
#'
sf_voronoi_diagram = \(sfj){
  if (!(sf_geometry_type(sfj) %in% c('point','multipoint'))){
    stop("Only (multi-)point vector objects are supported to generate voronoi diagram")
  }

  suppressWarnings({
   sfj_voronoi = sfj %>%
     sf::st_geometry() %>%
     sf::st_union() %>%
     sf::st_voronoi() %>%
     sf::st_collection_extract() %>%
     sf::st_sf(geometry = .) %>%
     tibble::as_tibble() %>%
     sf::st_as_sf()
   })

  return(sfj_voronoi)
}
