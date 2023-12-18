## code to prepare `DATASET` dataset goes here

# code to scrape for 1984 for books

library(jsonlite)

URL<- paste0("https://libtools.smith.edu/bento/results.php?",
                  "mat=","books",
                  "&smith=&peer_reviewed=&full_text=&sort=&fieldcode=&perpage=6&",
                  "query=","1984"
)

x <- jsonlite::read_json(URL)

cover_image <- purrr::map_chr(x, "image")
title = purrr::map_chr(x, "jtitle")

SSHelper_data <- data.frame(title = title,
                            image = cover_image)



usethis::use_data(SSHelper_data, overwrite = TRUE)

