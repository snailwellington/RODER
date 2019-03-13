
#' Get NPS price data
#'
#' Receive NPS data for EE, LV, LT and FI
#' @param query_start Start datetime to the minute, %Y-%m-%d %H:%M, e.g. '2019-01-01 00:00'
#' @param query_end End datetime to the minute, e.g. '2019-01-02 00:00'
#' @keywords NPS price
#' @export
#' @import tidyr
#' @import dplyr
#' @import httr



get_NPS_price <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){


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
    mutate(datetime = as.POSIXct(datetime,tz = "GMT", origin="1970-01-01"))

  ## return output
  return(dataset)
}


