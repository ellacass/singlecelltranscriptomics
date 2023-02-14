#!/bin/bash


#SBATCH --job-name=cdhit
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/cdhit-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/cdhit-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
res="${wd}/results"
od="${res}/busco"
ref="${wd}/data/refs/GHAQ01.renamed.fasta"


###ENVIRONMENT
module load cdhit
module load transdecoder

### VARIABLES
###none 

###first command with CD-hit
echo "Started a `date`"

echo "cd-hit-est i ${ref} -o ${od}/cd_hit_result -c 1 -T 8 -d 50"
cd-hit-est -i ${ref} -o ${od}/cd_hit_result -c 1 -T 8 -d 50 -aS 1
echo "Finished at `date`"




