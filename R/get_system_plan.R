#' Get System plan data
#'
#'
#' @export
#' @import dplyr
#' @import httr


get_system_plan <- function(query_start = paste(Sys.Date()-31,"00:00"),query_end = paste(Sys.Date()-1,"00:00")){


  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/system/with-plan?start=&end="

  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))

  ## turn data to dataframe and reformat to datetime series

  dataset_plan <- jsonlite::fromJSON(json_data$url)$data[2] %>%
    as.data.frame() %>%
    rename(datetime = plan.timestamp) %>%
    mutate(datetime = as.POSIXct(datetime,tz = "", origin="1970-01-01"))

  ## return output

  return(dataset_plan)
}

