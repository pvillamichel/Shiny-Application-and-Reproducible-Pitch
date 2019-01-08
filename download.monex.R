download.monex<- function() {
        
        library(XML)
        
        url<-paste("http://indicadoreseconomicos.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?CodCuadro=770&Idioma=1&FecInicial=2018/12/29&FecFinal=2100/12/31&Exportar=True", sep="")
        
        DATA <- readHTMLTable(url, stringsAsFactors=FALSE, header=FALSE, dec=",")$Table9 
        
        DATA<-as.data.frame(t(DATA)[-1,5:21][,-c(2,9:15)])
        
        NAMES<-c("Date", "Open", "Close", "Low", "High", "Mean", "WA", "Volume", "Num")
        
        colnames(DATA)<-NAMES
        rownames(DATA)<-NULL
        
        DATA<-as.data.frame(apply(DATA, 2, function(x) (as.character(x))))
        
        DATA[,2:9]<-apply(DATA[,2:9], 2, function(x) as.numeric(sub(",",".",x)))
        
        DATA<- DATA[DATA$Volume>0,]
        DATA<- DATA[complete.cases(DATA),]
        
        MONTHS <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun" , "Jul", "Ago", "Set", "Oct", "Nov", "Dic")

        DATA$Date <- gsub(" ", "-", DATA$Date)
        
        for (i in 1:12) {
                DATA$Date<-gsub(MONTHS[i], i, DATA$Date) 
        }
        
        DATA$Date <- as.Date(DATA$Date, "%d-%m-%Y")
        
        

        return(DATA)
}