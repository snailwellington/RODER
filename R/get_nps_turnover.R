

#' Get NPS turnover data
#'
#' Receive NPS data for EE, LV, LT and FI
#' @param query_start Start datetime to the minute, %Y-%m-%d %H:%M, e.g. '2019-01-01 00:00'
#' @param query_end End datetime to the minute, e.g. '2019-01-02 00:00'
#' @keywords NPS price
#' @export
#' @import tidyr
#' @import dplyr
#' @import httr



get_NPS_turnover <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){

  library(tidyr)
  library(dplyr)


  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/nps/turnover?start=&end="

  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))

  ## turn data to dataframe and reformat to datetime series
  dataset <- jsonlite::fromJSON(json_data$url)$data %>%
    as.data.frame() %>%
    select(ee.timestamp,2:3,5:6,8:9,11:12) %>%
    rename(datetime = ee.timestamp) %>%
    mutate(datetime = as.POSIXct(datetime,tz = "GMT", origin="1970-01-01"))

  ## return output
  return(dataset)
}

