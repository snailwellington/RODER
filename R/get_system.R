

get_system <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){
  
  library(tidyr)
  library(dplyr)
  
  
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



  
get_system_plan <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){
  
  library(tidyr)
  library(dplyr)
  
  
  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/system/with-plan?start=&end="
  
  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))
  
  ## turn data to dataframe and reformat to datetime series

  dataset_plan <- jsonlite::fromJSON(json_data$url)$data[2] %>% 
    as.data.frame() %>% 
    rename(datetime = plan.timestamp) %>% 
    mutate(datetime = as.POSIXct(datetime,tz = "GMT", origin="1970-01-01"))
  
  ## return output

  return(dataset_plan)
}

get_system_real <- function(query_start = '2019-01-01 00:00',query_end = '2019-01-02 00:00'){
  
  library(tidyr)
  library(dplyr)
  
  
  ## Defined GET address
  URL <- "http://dashboard.elering.ee/api/system/with-plan?start=&end="
  
  ## GET data with httr
  json_data <- httr::GET(URL,
                         query= list(start = query_start,end = query_end))
  
  ## turn data to dataframe and reformat to datetime series
  dataset_real <- jsonlite::fromJSON(json_data$url)$data[1] %>% 
    as.data.frame() %>% 
    rename(datetime = real.timestamp) %>% 
    mutate(datetime = as.POSIXct(datetime,tz = "GMT", origin="1970-01-01"))
  
    ## return output
  return(dataset_real)

}


