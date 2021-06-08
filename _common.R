library("magrittr")
get_pic <- function(id, alt, width) {
  
  info <- httr::GET(
    paste0("https://api.pexels.com/v1/photos/", id),
    httr::add_headers(Authorization = Sys.getenv("PEXELS_KEY"))
  ) %>%
    httr::content()
  download.file(info$src$large, paste0(id, ".jpeg"))
  cat("```{=html}\n")
cat(paste0('{', '{< figure src="',
paste0(id, ".jpeg"),
'" alt="',
alt,
'" caption="Picture by [',
info$photographer,
' on Pexels](',
info$url,
')." width="',
width , '" >}', '}'))
cat("\n```\n")
}
