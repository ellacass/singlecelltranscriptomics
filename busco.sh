#!/bin/bash

#SBATCH --job-name=busco
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/busco-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/busco-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
res="${wd}/results"
od="${res}/busco"
ref=( ${wd}/results/dedup/*.fasta )


###VARIABLES
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
refs="${ref[$pos]}"


###ENVIRONMENT
module load conda
conda activate busco-5.4.4
module list

### VARIABLES

echo "Started at `date`"
echo "busco -f -i ${refs} -l metazoa -o ${od}/tripedialia_metazoa -m tran -c 16 --download_path ${wd}/scripts"
busco -f -i ${refs} -l metazoa -o ${od}/busco_new.${refs}-m tran -c 16 --download_path ${wd}/scripts

echo "Finished at `date`"
