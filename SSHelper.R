library(httr)
library(rvest)
library(purrr)
library(gridExtra)
library(grid)




library_search <- function(search_terms, category, ...){



library_search <- function(search_terms, place_to_search, ...){


  place_to_search <- as.character(place_to_search)

search_terms = readline(prompt = "What is the title of your request?: ")
category = readline(prompt = "Is your request a books, articles, rare_books, video, journals or special_collections?: ")


  category_list <- list("books", "articles", "rare_books", "video", "journals", "special_collections")

  if(!(place_to_search%in% category_list)){
    stop("The provided category is not available")
  }



  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){

    stop("Input wasn't a character. Please try again")
  }



    stop("Input wasn't a character. Please try again")
  }


library(httr)
library(rvest)
library(purrr)


<<<<<<< HEAD

library_search <- function(search_terms, category, ...){

  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){
    stop("Input wasn't a character. Please try again")
  }

=======
  if(is.na(title)){

    stop("Input wasn't a character. Please try again")
  }

  user_input = title


  place_to_search <- "journals"



>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3
  URL <- paste0("https://libtools.smith.edu/bento/results.php?",
                "mat=", place_to_search,
                "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
                "query=", search_terms
  )


<<<<<<< HEAD
  x <- jsonlite::read_json(URL)

  # str(x)

  docs = map_chr(x$docs, "j_title")

  # for (j in length(docs)){
  #   num = unlist(docs[[j]])
  #
  #   num[[1]]
  #
  #   if(num[[1]] == "j_title" ){
  #
  #   }
  # }

  return(docs)

=======



  x <- jsonlite::read_json(URL)

  # str(x)

  docs = map_chr(x$docs, "j_title")

  # for (j in length(docs)){
  #   num = unlist(docs[[j]])
  #
  #   num[[1]]
  #
  #   if(num[[1]] == "j_title" ){
  #
  #   }
  # }

  return(docs)

>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3
}


search_terms = readline(prompt = "What is the title of your request?: ")
category = readline(prompt = "I your request a books, articles, rare_books, video, journals or special_collections?: ")


library_search(search_terms, category)


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





<<<<<<< HEAD
=======
  URL_orig <- "https://libtools.smith.edu/bento/results.php?mat=journals&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&query=1984"


  x <- jsonlite::read_json(URL)
  str( x)
>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3




<<<<<<< HEAD
=======
  if ( place_to_search == "journals"){
    cover_images <- map_chr(x$docs, "coverimage")
    journals = map_chr(x$docs, "j_title")
    names(cover_images) <- journals
    journals

    draw_image(cover_images)

  } else if ( place_to_search == "books"){
    books = map_chr(x$e.fivecolleges.fol., "jtitle")
    books
    # cover_image = map_chr(x$, "")

    # }else if (category == "articles"){
    #   # artcles = map_chr(x)

  }else if (place_to_search == "rare_books"){
    rare_books = map_chr(x$e.fivecolleges.fol., "full")
    rare_books

  }else if (place_to_search == "video"){
    video = map_chr(x$e.fivecolleges.fol., "full ")
    video

  }else if( place_to_search == "special_collections"){
    special_collections = map_chr(x$ries.2.resources., "full")
    special_collections

  } else{

    stop("Category not found")
  }
>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3




<<<<<<< HEAD














# book_title<- function(title,...){
#
#   title <- as.character(title)
#
#   if(is.na(title)){
#     stop("Input wasn't a character. Please try again")
#   }
#
#   user_input = title
#
#
#   query_string <- paste0("https://www.smith.edu/libraries/discover/search.php?fieldcode=&query=",
#                          user_input,
#                          "&box=books&box=articles&box=rare_books&box=video&box=journals&box=special_collections"
#   )
#   x <- httr::GET(query_string)
#
#   library_section <- rvest::read_html(x$content) |>
#     html_element(css = ".col-md-4")
#
#   library_section |>
#     html_elements(".btitle")
#
#   return(library_section)
# }

=======
}

draw_image<- function(cover_images,...){

  n <- length(cover_images)
  n_row <- floor(sqrt(n))
  n_col <- ceiling(n / n_row)

  # Set up the plot layout
  par(mfrow = c(n_row, n_col))

  for (j in cover_images){

    img_type <- tools::file_ext(j)

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
>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3






<<<<<<< HEAD
=======
# grid graphics subplots--> to show all images
>>>>>>> 81ab61ecce614d2d3c607e457491d7a86a8b5bf3







