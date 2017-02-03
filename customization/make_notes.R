library(stringr)
curr_file <- str_split(commandArgs()[length(commandArgs())], "'")[[1]][2]
out_file <- str_replace(curr_file, ".Rmd", "_notes.Rmd")
f_out <- file(out_file, open="w")
close(f_out)
f_out <- file(out_file, open="a")
text <- readLines(curr_file)

YAML_header_flag = FALSE
convert_flag = FALSE

writeLines("---", f_out)
for(line in text){
  if(line=="# <img src=\"../images/howto.jpg\"></img>") {

  } else if(!is.na(str_match(line, "^output:"))){
    YAML_header_flag <- TRUE
    writeLines(c("output:",
                 "  pdf_document:",
                 "    toc: true",
                 "    toc_depth: 2",
                 "    keep_tex: true",
                 "geometry: right=2.5in",
                 "---"), f_out)
  } else if(YAML_header_flag) {
    if(!is.na(str_match(line, "^---"))){
      YAML_header_flag <- FALSE
    }
  } else if(!is.na(str_match(line, "^-+$"))){
    
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
