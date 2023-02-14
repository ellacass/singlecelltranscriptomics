#!/bin/bash


#SBATCH --job-name=multitransdecoder
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/multitransdecoder-%j-%A.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/multitransdecoder-%j-%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
res="${wd}/results"
inFile="${res}/dedup/*.cds"
od="${res}/dedup"

icos=( 0.95 0.97 0.99 )


module load cdhit

###VARIABLES
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
ico="${icos[$pos]}"

###ENVIRONMENT
echo "Started at `date`"

echo "cd-hit-est -i ${inFile}.cds -aL 0.9 -aS 0.9 -T 8 -d 50 -c ${ico}"
cd-hit-est -i ${inFile} -aL 0.9 -aS 0.9 -T 8 -d 50 -c ${ico} -o ${od}/dedup_clustered.${ico}.fasta

echo "Finished at `date`"
