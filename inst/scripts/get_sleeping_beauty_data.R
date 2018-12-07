# get sleeping beauty gene list
# RUN FROM PROJECT ROOT
library(readxl)
tmpdir = tempdir()
download.file('https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4767150/bin/NIHMS755288-supplement-Supplementary_Tables.xlsx',
              destfile = file.path(tmpdir,"NIHMS755288-supplement-Supplementary_Tables.xlsx"))
sleepingbeauty = do.call('rbind',
            lapply(1:3, function(z) {
              res = read_xlsx(file.path(tmpdir,'NIHMS755288-supplement-Supplementary_Tables.xlsx'),sheet = z, skip=1)
              res = res[!is.na(res[[7]]),]
              res = res[,1:7]
  }))
sleepingbeauty[,2:5] = apply(sleepingbeauty[,2:5],2,as.numeric)
save(sleepingbeauty,file='data/sleepingbeauty.Rda')
