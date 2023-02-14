#!/bin/bash

#SBATCH --job-name=sam_conversion
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/samconversion-%j_%A.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/samconversion-%j_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at


###ENVIRONMENT
module load samtools
module list

###constants
wd="/scratch/students/cassidy/transcriptome/data/results/map/"
sams=( ${wd}/*.sam )

###VARIABLES
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
inSam="${sams[$pos]}"
outBam=`basename ${inSam}`
outBam="${wd}${outBam%.sam}.bam"
sortedBam="${outBam%.bam.sorted.bam}"
filteredBam="${sortedBam%%.*}.filtered.bam"

echo "Started at `date`"

echo "samtools view -@ 4 -b -o ${outBam} ${inSam}"
samtools view -@ 4 -b -o ${outBam} ${inSam}

echo "samtools sort -@ 4 -o ${sortedBam} ${outBam}"
samtools sort -@ 4 -o ${sortedBam} ${outBam}

echo "samtools view -@ 4 -b -q 20 -o ${filteredBam} ${sortedBam}"
samtools view -@ 4 -b -q 20 -o ${filteredBam} ${sortedBam} 

echo "Finished at `date`"
