#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Firregulare
Rscript scripts/chrom_correspondance.R Firregulare
