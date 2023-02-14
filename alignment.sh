#!/bin/bash

#SBATCH --job-name=star_align
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/star_align-%j_%A.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/star_align-%j_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at


###ENVIRONMENT
module load star
module list

wd="/scratch/students/cassidy/transcriptome/data"
refDir="${wd}/refs/jaNemVect1.1_STAR"
reads=( ${wd}/reads/*.fastq )
resDir="${wd}/results/map"

###Variables UNPAIRED
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
reads1=${reads[$pos]}
prefix=$(basename ${reads1})
prefix="${prefix%.fastq}"

###EXECUTION
echo "Started at `date`"

echo "mkdir -p ${resDir}"
mkdir -p ${resDir}

echo "STAR --runThreadN 16 --genomeDir ${refDir} --readFilesIn ${reads1} --outFileNamePrefix "${resDir}/${prefix}""
STAR --runThreadN 16 --genomeDir ${refDir} --readFilesIn ${reads1} --outFileNamePrefix "${resDir}/${prefix}"

echo "Finished at `date`"
