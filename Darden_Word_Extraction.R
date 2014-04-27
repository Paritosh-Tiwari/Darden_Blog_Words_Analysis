library(XML)
library(stringr)
url = list("http://lifeismyclassroom.wordpress.com/", "http://lifeismyclassroom.wordpress.com/page/2/","http://lifeismyclassroom.wordpress.com/page/3/", "http://lifeismyclassroom.wordpress.com/page/4/","http://lifeismyclassroom.wordpress.com/page/5/","http://lifeismyclassroom.wordpress.com/page/6/")
html = list()
text = list()
for (i in seq_along(1:6)) {
        
        html[[i]] = htmlTreeParse(url[[i]],useInternalNodes = T)
        text[[i]] = xpathSApply(html[[i]],"//div[@class = 'entry-content']",xmlValue)

}


## Making a word Frequency Table

dump("text",file = "Darden_Blog.txt")
raw_text = readLines("Darden_Blog.txt")
raw_text_split = strsplit(raw_text, " ")
raw_dump = " "

for (i in seq_along(1:39)){
        raw_dump = c(raw_dump,raw_text_split[[i]])
}

# Converting all to lower case
raw_dump = tolower(raw_dump)

## Removing characters
raw_dump = gsub(",","",raw_dump)
raw_dump = gsub(":","",raw_dump)
raw_dump = gsub(";","",raw_dump)
raw_dump = gsub("\\\\","",raw_dump)
raw_dump = gsub("\\.","",raw_dump)
raw_dump = gsub("\\'","",raw_dump)
raw_dump = gsub("\\\\n","",raw_dump)
raw_dump = gsub("\\\\t","",raw_dump)
raw_dump = gsub("-","",raw_dump)
raw_dump = gsub("\\(","",raw_dump)
raw_dump = gsub("\\)","",raw_dump)
raw_dump = gsub("!","",raw_dump)
raw_dump = gsub("?","",raw_dump)

## Trimming the data

raw_dump = str_trim(raw_dump)

## Coverting to factor
raw_dump_table = as.factor(raw_dump)
raw_dump_table = sort(raw_dump_table)
word_frequency = table(raw_dump_table)
word_frequency_table = as.data.frame(word_frequency)

## Writing to output file
write.csv(word_frequency_table, "Darden_Word_Frequency_Table.csv")
