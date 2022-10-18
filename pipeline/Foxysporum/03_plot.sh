#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Foxysporum
Rscript scripts/chrom_correspondance.R Foxysporum
