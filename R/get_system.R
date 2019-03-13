#' Get NPS turnover data
#'
#'

#' @export
#' @import dplyr
#' @import httr


get_system <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){


  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/system?start=&end="

  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))

  ## turn data to dataframe and reformat to datetime series
  dataset <- jsonlite::fromJSON(json_data$url)$data %>%
    rename(datetime = timestamp) %>%
    mutate(datetime = as.POSIXct(datetime,tz = "GMT", origin="1970-01-01"))

  ## return output
  return(dataset)
}



