#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Ffalciforme
Rscript scripts/chrom_correspondance.R Ffalciforme
