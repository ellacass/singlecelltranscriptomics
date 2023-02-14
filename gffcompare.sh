#!/bin/bash

#SBATCH --job-name=gffmerge
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/index_star-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/index_star-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

export PATH="/scratch/molevo/jmontenegro/software/bin:${PATH}"

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome/data"
ptf1="${wd}/results/stringtie"
list=( ${pft1}/*.gff ${pft1}/*.gft )
pft2="${wd}/refs"
gffcomb= ( ${pft1}/. ${pft2}/*.gff )

 
gffcompare -o ${wd}mergecompare ${list[@]}
