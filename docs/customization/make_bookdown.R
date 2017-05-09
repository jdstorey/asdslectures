library(stringr)
curr_file <- str_split(commandArgs()[length(commandArgs())], "'")[[1]][2]
out_file <- str_replace(curr_file, ".Rmd", "_bookdown.Rmd")
f_out <- file(out_file, open="w")
close(f_out)
f_out <- file(out_file, open="a")
text <- readLines(curr_file)

week <- paste0("# ", str_split(text[2], " -- ")[[1]][2])
fileroot <- str_split(out_file, "_")[[1]][1]
fileroot <- tail(str_split(fileroot, "/")[[1]], n=1)
week <- paste0(week, " {#", fileroot, "}")

header <- str_which(text, "^---$")
text <- text[-drop(mapply(":",header[1],header[2]))]

tailer <- str_which(text, "^# Extras$")
text <- text[(1:(tailer-1))]

convert_flag <- FALSE

writeLines(week, f_out)

for(line in text){
  if(line=="# <img src=\"./images/howto.jpg\"></img>") {

  } else if(!is.na(str_match(line, "^-+$"))){
    
  } else if(!is.na(str_match(line, "^<[^h]"))){
    
  } else if(!is.na(str_match(line, "^#+"))){
      writeLines(paste0("#", line), f_out)
  } else if(!is.na(str_match(line, "^```")) && !is.na(str_match(line, "converttonotes"))){
    convert_flag <- TRUE
  } else if(convert_flag){
    if(!is.na(str_match(line, "^```"))){
      convert_flag <- FALSE
    }
  } else{
    writeLines(line, f_out)
    print(line)
  }
  print(line)
}



writeLines(c("## Session Information",
             "\n",
             "```{r}",
             "sessionInfo()",
             "```"), f_out)
