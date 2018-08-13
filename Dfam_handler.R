#This file is design to download and extract information from Dfam database.

#Downloads
DFAM_URL= "http://www.dfam.org"
DFAM_VERSION = 2.0
DFAM_DATABASE_DIR = "/Users/quanyuanhe/OneDrive/MyProjects/repetative_seq/data_source/our_database/Dfam"

library(HelpersMG)
library(R.utils)
setwd(DFAM_DATABASE_DIR)

# Function to Dfam for nrph.hits
# TSV list of all non-redundant matches found in the
# given assembly and that score above the GA threshold
getDfamNrphHits = function (db_dir, version, genome){
  gz_file_url = paste(genome,"_dfam.nrph.hits.gz",sep="")
  print(gz_file_url)
  file_url = paste(genome,"_dfam.nrph.hits",sep="")
  print(file_url)
  wget_url = paste("http://www.dfam.org/web_download/Release/Dfam_",as.character(version),"/",gz_file_url, sep="")
  if (!file.exists(paste(db_dir,gz_file_url,sep='/'))){
    hit.gz <- wget(wget_url)
  }
  file_path = paste(db_dir,file_url,sep='/')
  if (!file.exists(file_path)){
    gunzip(file_path)
  }
  result = read.table(file_url,header= TRUE, sep='\t')
  return (result)
}

hg38_nrph_hits = getDfamNrphHits(DFAM_DATABASE_DIR, "2.0", "hg38")
mm10_nrph_hit = getDfamNrphHits(DFAM_DATABASE_DIR,"2.0","mm10")