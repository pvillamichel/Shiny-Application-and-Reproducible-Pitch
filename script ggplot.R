MONEX_Diario <- function(inicio, WA=TRUE, Volume=TRUE, Transactions=TRUE) {
        
        invisible ( library(tidyquant) ) 
        invisible ( library(bdscale) ) 
        #library(gridExtra)
        #library(grid)
        invisible ( library(cowplot) ) 
        invisible ( source("update_DATA.R") ) 
        
        load("DATA.Rda")
        DATA<-update()
        
        
        main <- DATA[DATA$Date>=inicio,] %>%
                ggplot(aes(x = Date, y = Close)) +
                geom_candlestick(aes(open = Open, high = High, low = Low, close = Close), 
                                 fill_up = "green3", color_up = "green3", size=.3 ) +
                scale_x_bd(business.dates=DATA$Date) + 
                scale_y_continuous(sec.axis = dup_axis()) +
                theme(axis.text.x = element_blank(), 
                      plot.margin = margin(10, 5, 0, 5, "point"),
                      axis.text.y=element_text(colour="white", size=10),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      panel.background = element_rect(fill = "gray10"), 
                      plot.background = element_rect(fill = "black"),
                      panel.grid.major.x = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.major.y = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.minor = element_blank(),
                      plot.title = element_text(color="white", size=14, face="bold", hjust=0)) +
                labs(title = "MONEX: CRC/USD")
        
        volume <- DATA[DATA$Date>=inicio,] %>%
                ggplot(aes(x = Date, y = Volume/1000000)) +
                geom_bar(stat="identity") + 
                scale_x_bd(business.dates=DATA$Date) + 
                scale_y_continuous(sec.axis = dup_axis()) +
                theme(axis.text.x = element_blank(), 
                      plot.margin = margin(10, 5, 0, 5, "point"),
                      axis.text.y=element_text(colour="white",  size=10),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      panel.background = element_rect(fill = "gray10"), 
                      plot.background = element_rect(fill = "black"),
                      panel.grid.major.x = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.major.y = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.minor = element_blank(),
                      plot.subtitle = element_text(color="white", size=10, hjust=0)) +
                labs(subtitle = "Volume: US$ Millions")
        
        
        count <- DATA[DATA$Date>=inicio,] %>%
                ggplot(aes(x = Date, y = Num)) +
                geom_bar(stat="identity") + 
                scale_x_bd(business.dates=DATA$Date) + 
                scale_y_continuous(sec.axis = dup_axis()) +
                theme(panel.background = element_rect(fill = "gray10"), 
                      plot.margin = margin(10, 5, 0, 5, "point"),
                      axis.text.y=element_text(colour="white", size=10),
                      axis.text.x=element_text(colour="white", size=10),
                      axis.title.x=element_blank(),
                      axis.title.y=element_blank(),
                      plot.background = element_rect(fill = "black"),
                      panel.grid.major.x = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.major.y = element_line(color = "white", linetype = "dotted", size = 0.1),
                      panel.grid.minor = element_blank(),
                      plot.subtitle = element_text(color="white", size=10, hjust=0)) +
                labs(subtitle = "Number of transactions")
        
        if (WA==TRUE) main= main + geom_line(aes(x= Date, y=WA), color = 'white' )
        
        if (Volume==FALSE & Transactions==FALSE) {
                main <- main + theme(axis.text.x=element_text(colour="white", size=10))
                return(plot_grid(main, ncol = 1, align = "v", rel_heights = c(4)))
        }
        
        if (Volume==TRUE & Transactions==FALSE) {
                volume <- volume + theme(axis.text.x=element_text(colour="white", size=10))
                return(plot_grid(main, volume, ncol = 1, align = "v", rel_heights = c(4, 1.3)))
        }
        
        if (Volume==FALSE & Transactions==TRUE) {
                count <- count + theme(axis.text.x=element_text(colour="white", size=10))
                return(plot_grid(main, count, ncol = 1, align = "v", rel_heights = c(4, 1.3)))
                
        }
        
        if (Volume==TRUE & Transactions==TRUE) {
                return(plot_grid(main, volume, count, ncol = 1, align = "v", rel_heights = c(4, 1.2, 1.3)))
                
        }
        
        
        
        
}
# fechas del eje x meses




