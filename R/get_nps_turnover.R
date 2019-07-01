

#' Get NPS turnover data
#'
#'
#' @export
#' @import dplyr
#' @import httr



get_NPS_turnover <- function(query_start = paste(Sys.Date()-31,"00:00"),query_end = paste(Sys.Date()-1,"00:00")){


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
    mutate(datetime = as.POSIXct(datetime,tz = "", origin="1970-01-01"))

  ## return output
  return(dataset)
}

