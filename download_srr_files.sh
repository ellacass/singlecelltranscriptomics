#!/bin/bash

#SBATCH --job-name=downloadsra
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/downloadsra-%j_%A.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/downloadsra-%j_%A.error
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

### ENVIRONMENT
module load sratoolkit
module list

### CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
od="${wd}/data/reads"
#list=( SRR10907789 SRR10907790 SRR10907791 SRR10907792 )
list=( SRR8101521 )

### VARIABLE
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
acc=${list[$pos]}

## EXECUTION
echo "Started at `date`"

echo "fasterq-dump ${acc} -O ${od} -e 4"
fasterq-dump ${acc} -O ${od} -e 4

echo "Finished at `date`"
