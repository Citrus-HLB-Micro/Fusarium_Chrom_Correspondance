#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Ftorreyae
Rscript scripts/chrom_correspondance.R Ftorreyae
