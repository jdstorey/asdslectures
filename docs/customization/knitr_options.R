library(knitr)
library(tidyverse)

theme_set(theme_bw()+ theme(plot.title = element_text(hjust = 0.5)))

set.seed(508)

knit_hooks$set(small.mar = function(before, options, envir) {
  if (before) par(mar = c(4, 4, .1, .1))  # smaller margin on top and right
})

opts_chunk$set(fig.align="center", fig.height=5.5, fig.width=6, collapse=TRUE, 
               comment="", prompt=TRUE, small.mar=TRUE)

options(width=63)
