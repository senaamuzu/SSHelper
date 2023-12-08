library(httr)
library(rvest)
library(purrr)



library_search <- function(search_terms, category, ...){




search_terms = readline(prompt = "What is the title of your request?: ")
category = readline(prompt = "Is your request a books, articles, rare_books, video, journals or special_collections?: ")


library_search <- function(search_terms, category...){


  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){

    stop("Input wasn't a character. Please try again")
  }


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





  URL_orig <- "https://libtools.smith.edu/bento/results.php?mat=journals&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&query=1984"

  x <- jsonlite::read_json(URL)

  str(x)


}





search_terms <- "fear+and+loathing+in+las+vegas"

# This could be "books", "articles", "rare_books", "video", "journals" or "special_collections"
place_to_search <- "journals"

URL <- paste0("https://libtools.smith.edu/bento/results.php?",
              "mat=", place_to_search,
              "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
              "query=", search_terms
)

URL_orig <- "https://libtools.smith.edu/bento/results.php?mat=journals&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&query=1984"

x <- jsonlite::read_json(URL)

str(x)


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
















