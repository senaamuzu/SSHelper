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
#'
#' @return A list of category `SSHelper` with following fields
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
  # str( x)


  if ( place_to_search == "journals"){
    cover_images <- map_chr(x$docs, "coverimage")
    journals = map_chr(x$docs, "j_title")
    #  names(cover_images) <- journals
    # # journals
    # cover_images
    draw_image(cover_images)

  } else if (place_to_search == "books"){

    books = map_chr(x, "jtitle")
    books

    # draw_book_covers()

    # cover_image = map_chr(x$, "")

  } else if (place_to_search == "articles"){
      articles = map_chr(x, "full")

  } else if (place_to_search == "rare_books"){
    rare_books = map_chr(x, "full")
    rare_books

  }else if (category == "articles"){
    articles = map_chr(x, "title")
    articles

  }else if (place_to_search == "video"){
    video = map_chr(x, "full ")
    video

  }else if( place_to_search == "special_collections"){
    browser()
    special_collections = map_chr(x, "full")
    special_collections

  } else{

    stop("Category not found")
  }




}

#' Visualize
#'
#' Given an [`SSHelper`] object, this [`base::draw_image`] method retrieve an image file associated with
#' the category type from Smith College library and displays it in the graphics device.
#'
#' @param x An [`SSHelper`] SSHelper object
#'
#' @importFrom tools file_ext
#' @importFrom png readPNG
#' @importFrom jpeg readJPEG
#' @importFrom grid grid.raster
#' @importFrom graphics par
#'
#' @export
draw_image<- function(cover_images, ...){

  n <- length(cover_images)
  n_row <- floor(sqrt(n))
  n_col <- ceiling(n / n_row)

  # Set up the plot layout
  par(mfrow = c(n_row, n_col))

  for (j in cover_images){


    img_type <- tools::file_ext(j)
    #
    # tmp <- tempfile(pattern = "file",
    #                 tmpdir = tempdir()
    #   )
    #
    # utils::download.file(cover_images, destfile = tmp)

    tmp <- httr::GET(url = j)

    if (img_type == "png") {
      p <- png::readPNG(tmp$content)
    } else if (img_type == "jpg" || img_type == "jpeg") {
      p <- jpeg::readJPEG(tmp$content)
    } else {
      stop("unknown image format", img_type)
    }

    graphics::plot.new()
    grid::grid.raster(p)

  }

}
