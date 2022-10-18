#!/usr/bin/bash -l

module load ragtag
OUT=scaffold
REF=ref_genomes/Foxysporum
REXT=fna
QUERY=Foxy_genomes
QEXT=sorted.fasta
for ref in $(ls $REF/*.${REXT})
do
	refbase=$(basename $ref .${REXT})
	for query in $(ls $QUERY/*.${QEXT}); do
		nm=$(basename $query .${QEXT})
		mkdir -p $OUT/$refbase
		ragtag.py scaffold $ref $query -o $OUT/$refbase/$nm -u
	done
done
