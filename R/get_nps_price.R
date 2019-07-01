
#' Get NPS price data
#'
#' @export
#' @import dplyr
#' @import httr



get_NPS_price <- function(query_start = paste(Sys.Date()-31,"00:00"),query_end = paste(Sys.Date()-1,"00:00")){


  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/nps/price?start=&end="

  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))

  ## turn data to dataframe and reformat to datetime series
  dataset <- jsonlite::fromJSON(json_data$url)$data %>%
    as.data.frame() %>%
    select(fi.timestamp,fi.price,ee.price,lv.price,lt.price) %>%
    rename(datetime = fi.timestamp) %>%
    mutate(datetime = as.POSIXct(datetime,tz = "", origin="1970-01-01"))

  ## return output
  return(dataset)
}


