update <- function() {
        
        source("download.monex.R")
        load("DATA.Rda")
        new<-download.monex()
        DATA<-rbind(DATA, new)
        row.names(DATA)<-NULL
        return(DATA)
     
}
