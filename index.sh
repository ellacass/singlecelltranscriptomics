#!/bin/bash

#SBATCH --job-name=star_index
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/index_star-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/index_star-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at


###VARIABLES
wd="/scratch/students/cassidy/transcriptome"
refDir="${wd}/data/refs"
refFasta=( ${refDir}/*.fasta )
od=

###ENVIRONMENT
module load star
module list

###VARIABLES
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
refs="${refFasta[$pos]}"


###EXECUTION
echo "Started at `date`"

echo "STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ${refDir} --genomeFastaFiles ${refFasta} --genomeSAindexNbases 13"
STAR --runThreadN 8 --runMode genomeGenerate --genomeDir ${refs} --genomeFastaFiles ${refFasta} --genomeSAindexNbases 13

echo "Finished at `date`"


