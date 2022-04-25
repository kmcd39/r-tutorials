#settings
#install.packages("gstat")
library(gstat)
library(dplyr)
library(sp)
library(tidyr)

id_rep <- rep(c(1,2), 20)
f <- rep(c(930,930.2), each=20)
perc <- rep(c(90, 80), each=10)

x <- sample(1:50, 40)
y <- sample(50:100, 40)
E <- runif(40)
df <- data.frame(id_rep, perc, x,y, f, E)
df_split <- split(df, list(df$id_rep, df$perc, df$f), drop = TRUE, sep="_")

#grid
x.range <- range(df$x)
y.range <- range(df$y)

grid <- expand.grid(x = seq(x.range[1], x.range[2], by=1), 
                    y = seq(y.range[1], y.range[2], by=1))
coordinates(grid) <- ~x + y

# ==============================================
# NEW function
# ==============================================

idp = seq(from = 1, to = 3, by = 0.5)
nmax = Inf# seq(from = 3, to = 6, by = 1)

#interpolation
lst_interp_idw <- lapply(df_split, function(X) {
  
  coordinates(X) <- ~x + y
  
  df_interp <- vector(length(idp)*length(nmax), mode = "list" )
  
  k <- 0
  
  for(i in idp) {
    
    for(j in nmax) {
      
      # print(paste(i, j))
      
      # Iterator
      k <- k + 1
      
      E_idw= idw(E ~ 1, X, grid, nmax = i, idp = j) %>% as.data.frame()
      
      df_interp[[k]] <- select(E_idw, x,y,E_pred=var1.pred)
      
    }
  }
  
  return(df_interp)
})

# ==============================================
library(ggplot2)

lengths(lst_interp_idw)

purrr::map(1:lengths(lst_interp_idw)[1],
    ~{
      lst_interp_idw$`1_80_930`[[.]] %>% 
      ggplot() +
      geom_tile(aes(x = x, y=y,
                    fill = E_pred))
      }
)
