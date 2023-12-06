library(httr)
library(rvest)


search_terms = readline(prompt = "What is the title of your request?: ")
category = readline(prompt = "I your request a books, articles, rare_books, video, journals or special_collections?: ")


library_search <- function(search_terms, category...){

  search_terms  <- as.character(search_terms)

  if(is.na(search_terms)){
    stop("Input wasn't a character. Please try again")
  }

  user_input = title

  place_to_search <- "journals"

  URL <- paste0("https://libtools.smith.edu/bento/results.php?",
                "mat=", place_to_search,
                "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
                "query=", search_terms
  )

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









