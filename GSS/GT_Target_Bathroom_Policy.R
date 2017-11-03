library('datasets')
library(gtrendsR)
usr <- "fredoXVII@gmail.com"  # alternatively store as options() or env.var
psw <- "gm02171977"        # idem
gconnect(usr, psw)       # stores handle in environment
head(countries[which(countries$code == 'US'),])
gt_trend <- gtrends(c("Target bathroom policy") , c("US-MN") )
plot(gt_trend)        # data set also included in package
plot(gt_trend, type = "geo" , which = 5 )
national_trend <- gt_trend$trend

states_abb <- cbind(state.name , state.abb)

gt_trend <- gtrends(c("Target bathroom policy") , c("US-MN") )

for (i in 1:length(state.abb)){
  sprintf('gt_trend_%s <- gtrends(c("Target bathroom policy") , c("US-state.abb[%s]") ) ' , i ) 
}

i <- 'Ak'
state_ds <- sprintf("gt_trend_%s" , i )

for (i in state.abb) { 
  if (i %in% c('AK','RI','VT')) {next}
  state <- sprintf("US-%s" , i)
  state_ds <- sprintf("gt_trend_%s" , i )
  state_ds <-  gtrends(c("Target bathroom policy") , c(state) )
  #return(state_ds)
}       
        
for (i in seq(along = state.abb)) {
          paste0("gt_trend_", state.abb[i]) <- state.abb[i]
        }
        head(Income)