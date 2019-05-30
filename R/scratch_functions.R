# These are functions that were created at some point but then we decided weren't used anymore.
# Kind of a recycle bin but I don't want to fully erase them.

# FILTER the percentage of observed compounds
voc_filter <- function(voc_data, threshold = NULL){
  voc_data %>% 
    select(-famid, -sampid, -ssex) %>% 
    mutate_if(is.numeric, function(x) ifelse(x > 0, 1, 0)) %>% 
    colSums() %>% 
    data.frame() %>% 
    rownames_to_column() %>%
    setNames(., c("voc", "count")) %>% 
    mutate(prcnt = count/nrow(voc_data)) %>% 
    filter(prcnt >= threshold) -> voc_filter
  
  voc_data %>% 
    select(famid, sampid, ssex, c(voc_filter$voc))
  
}