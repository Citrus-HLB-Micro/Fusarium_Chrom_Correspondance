#!/usr/bin/bash -l
SRC=scaffold
TARG=scaffold_agp
mkdir -p $TARG
pushd $TARG
for dir in $(ls ../$SRC)
do
	d=$(echo -n $dir | perl -p -e 's/_genomic//')
	mkdir -p $d
	for target in $(ls ../$SRC/$dir)
	do
		ln -s $(realpath ../$SRC/$dir/$target/*.agp) $d/$target.agp
	done
done
