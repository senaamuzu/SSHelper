library(httr)
library(rvest)


book_title<- function(title,...){

  title <- as.character(title)

  if(is.na(title)){
    stop("Input wasn't a character. Please try again")
  }

  user_input = title


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














