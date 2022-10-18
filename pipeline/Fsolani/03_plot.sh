#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Fsolani
Rscript scripts/chrom_correspondance.R Fsolani
