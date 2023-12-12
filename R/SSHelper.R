library(httr)
library(rvest)
library(purrr)
library(gridExtra)
library(grid)
library(magick)

#' @export
library_search <- function(search_terms, place_to_search, ...){

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
  str( x)




  if ( place_to_search == "journals"){
    cover_images <- map_chr(x$docs, "coverimage")
    journals = map_chr(x$docs, "j_title")
    names(cover_images) <- journals
    journals

    draw_image(cover_images)

  } else if ( place_to_search == "books"){

    books = map_chr(x, "jtitle")
    books

    draw_book_covers()

    # cover_image = map_chr(x$, "")

  } else if (place_to_search == "articles"){
      articles = map_chr(x, "full")

  } else if (place_to_search == "rare_books"){
    rare_books = map_chr(x, "full")
    rare_books

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

draw_image<- function(cover_images,...){

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
      p <- png::readJPNG(tmp$content)
    } else if (img_type == "jpg" || img_type == "jpeg") {
      p <- jpeg::readJPEG(tmp$content)
    } else {
      stop("unknown image format", img_type)
    }

    resized_p<- image_scale(p, "600x600")
    graphics::plot.new()
    grid::grid.raster(resized_p)

  }

}


# magick::image_read
#
# jpeg::readJPEG

# search_terms = readline(prompt = "What is the title of your request?: ")
# category = readline(prompt = "I your request a books, articles, rare_books, video, journals or special_collections?: ")



#
# search_terms <- "fear+and+loathing+in+las+vegas"
#
# # This could be "books", "articles", "rare_books", "video", "journals" or "special_collections"
# place_to_search <- "journals"
#
# URL <- paste0("https://libtools.smith.edu/bento/results.php?",
#               "mat=", place_to_search,
#               "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
#               "query=", search_terms
# )
#
# URL_orig <- "https://libtools.smith.edu/bento/results.php?mat=journals&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&query=1984"
#
# x <- jsonlite::read_json(URL)
#
# str(x)






# grid graphics subplots--> to show all images








