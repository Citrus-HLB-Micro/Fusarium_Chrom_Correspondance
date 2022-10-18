library(ggplot2)
library(tidyverse)
library(fs)
library(cowplot)
species="Foxysporum"
args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 1 ) {
  species = args[1]
}

if (! file.exists("plots") ) {
  dir.create("plots")
}
plotdir=sprintf("plots/%s",species)
if (! file.exists(plotdir) ){
  dir.create(plotdir)
}

data_dir = paste0("scaffold_agp/",species)
refgenome = fs::dir_ls(data_dir)

chrom_map <- function(indir) { 
  refname = basename(indir)
  agp_files <- fs::dir_ls(indir, regexp = "\\.agp$")
  agpdata <- agp_files %>% map_dfr(read_tsv, .id = "source", skip=2, 
                                   col_names = c("Ref", "Ref_Start", "Ref_End", "part_number","Type","Query","Query_Start","Query_End","Linkage")) %>% 
    filter(! str_detect(Ref,"^scaffold|^tig")) %>%
    mutate(src = gsub('\\S+_(\\S+)\\.agp','\\1',basename(source))) %>% 
    mutate(Chrom=gsub('\\.1_RagTag','',Ref)) %>% select(-c(source,Ref))
  source_names = agpdata %>% select(src) %>% distinct()
  
  chromobs = agpdata %>% select(src,Chrom) %>% distinct() %>%  mutate(present = 1) 
  
  #  matrix <- agpdata %>% select(src,Ref) %>% distinct() %>%  mutate(present = 1) %>% 
  #    pivot_wider(names_from = src, values_from = present) %>% mutate_at(vars(source_names$src), ~ifelse(is.na(.), 0, 1)) %>% rownames_to_column(var = "Ref")
  
  #  matrix
  
  p <- ggplot(chromobs, aes(src, Chrom, fill=present)) + 
    geom_tile() +
    theme_cowplot(12)
  save_plot(sprintf("%s/ChromPresAbsence_%s.pdf",plotdir,refname), p,base_height=8,base_width=15)
}
lapply(refgenome,chrom_map)
