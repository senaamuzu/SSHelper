library(httr)
library(rvest)
library(purrr)
library(gridExtra)
library(grid)

#' @title Retrieve metadata from Smith College library
#'
#' @description
#' A short description...
#'
#' @param search_terms  user input specifying the library category of choice
#' books, articles, rare_books, video, journals, and special_collections
#'
#' @param place_to_search user input specifying the title of the requested source
#'
#' @param ... Currently ignored
#'
#' @return A data frame of lists of requested catalog `library_search` with following fields
#' * journals
#' * books
#' * articles
#' * video
#' * special_collections
#'
#' @importFrom jsonlite read_json
#' @export
library_search <- function(search_terms, place_to_search, ...) {

  place_to_search <- as.character(place_to_search)

  category_list <- list("books", "articles", "rare_books", "video", "journals", "special_collections")

  if(!(place_to_search%in% category_list)){
    stop("The provided category is not available")
  }


  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){
    stop("Input wasn't a character. Please try again")
  }

  URL <- paste0("https://libtools.smith.edu/bento/results.php?",
                "mat=", place_to_search,
                "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
                "query=", search_terms
  )

  x <- jsonlite::read_json(URL)

  if (place_to_search == "journals"){
    cover_image <- purrr::map_chr(x$docs, "coverimage")
    title = purrr::map_chr(x$docs, "j_title")

  } else if (place_to_search == "books"){
    cover_image <- purrr::map_chr(x, "image")
    title = purrr::map_chr(x, "jtitle")

 } else if (place_to_search == "articles"){
   cover_image = NA
   title = purrr::map_chr(x, "full")

  } else if (place_to_search == "rare_books"){
    cover_image = NA
    title = purrr::map_chr(x, "full")

  } else if (place_to_search == "video"){
    cover_image <- purrr::map_chr(x, "image")
    title = purrr::map_chr(x, "full")

  } else if( place_to_search == "special_collections"){
    cover_image = NA
    title = purrr::map_chr(x, "full")

  }

  results <- data.frame(title = title,
                        image = cover_image)

  return(results)

}

#' Visualize
#'
#' Given an [`library_search`] object, this [`draw_image`] function retrieve an image file associated with
#' the category type from Smith College library and displays it in the graphics device.
#'
#' @param search_results An [`library_search`] SSHelper object
#' @param ... Currently ignored
#'
#' @importFrom tools file_ext
#' @importFrom png readPNG
#' @importFrom jpeg readJPEG
#' @importFrom grid grid.raster
#' @importFrom graphics par
#' @importFrom purrr map_chr
#'
#' @export
draw_image <- function(search_results, ...){

  cover_image <- search_results$image
  if ((is.null(cover_image))|| all(is.na(cover_image))){
    stop("No Cover Image Avaliable")
  }


  for (j in cover_image){

    if (j == ""){
      next
    }

    tmp <- httr::GET(url = j)

    p <- tryCatch(png::readPNG(tmp$content),
                  error = function(x) {
                    NULL
                  }
    )
    if (is.null(p)) {
      p <- tryCatch(jpeg::readJPEG(tmp$content),
                    error = function(x) {
                      NULL

                    }
      )

 readline("Please press ENTER to view next image")

    graphics::plot.new()
    grid::grid.raster(p)

    } else{
    stop("Image format not found")
  }

  }
  return(invisible(NULL))
}
