library(httr)
library(rvest)
library(purrr)
library(gridExtra)
library(grid)


place_to_search <- "journals"

library_search <- function(search_terms, place_to_search, ...){

place_to_search <- as.character(place_to_search)

 category_list <- list("books", "articles", "rare_books", "video", "journals", "special_collections")

  if(!(place_to_search )%in% category_list){
    stop("The provided category is not available")
  }



search_terms = readline(prompt = "What is the title of your request?: ")
category = readline(prompt = "I your request a books, articles, rare_books, video, journals or special_collections?: ")


library_search <- function(search_terms, category, ...){


  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){

book_title<- function(title,...){

  title <- as.character(title)

  if(is.na(title)){

    stop("Input wasn't a character. Please try again")
  }


  user_input = title


  place_to_search <- "journals"


  URL <- paste0("https://libtools.smith.edu/bento/results.php?",
                "mat=", place_to_search,
                "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
                "query=", search_terms
  )


  x <- jsonlite::read_json(URL)
  x

#  if ( category == "journals"){
#
#    cover_images <- map_chr(x$docs, "coverimage")
#
#    journals = map_chr(x$docs, "j_title")
#    names(cover_images) <- journals
#
#    return(journals)
#   # cover_images
#
#   # cover_image<- cover_images[1]
#
#
#
# #   image_list <- list()
# #
#
#   p <- list()
#
# for (j in cover_images){
#
#   img_type <- tools::file_ext (j)
#
#   tmp <- httr::GET(url = j)
#
#   if(img_type == "png"){
#     p <- png::readPNG(tmp$content)
#
#   }else if (img_type == "jpg" || img_type == "jpeg"){
#     p <- jpeg::readJPEG(tmp$content)
#   } else {
#     stop(" Unknown image format", img_type)
#   }
# #
#   graphics::plot.new()
#
#   # gridExtra::grid.raster(p)
#
#   gridExtra::grid.arrange(unlist(p),
#                           ncol = length(cover_images)/2,
#                           nrow = length(cover_images)/2)
#
# }
 # } else if (category == "")
 #
 #
 #  {
 #
 # }

}

library_search(1984, journals)
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


  query_string <- paste0("https://www.smith.edu/libraries/discover/search.php?fieldcode=&query=",
                         user_input,
                         "&box=books&box=articles&box=rare_books&box=video&box=journals&box=special_collections"
  )
  x <- httr::GET(query_string)

  library_section <- rvest::read_html(x$content) |>
    html_element(css = ".col-md-4")

  library_section |>
    html_elements(".btitle")

  return(library_section)
}












# grid graphics subplots--> to show all images





