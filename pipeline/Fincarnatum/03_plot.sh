#!/usr/bin/bash -l
#SBATCH -p short --mem 8gb 

mkdir -p plots/Fincarnatum
Rscript scripts/chrom_correspondance.R Fincarnatum
