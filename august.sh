#!/bin/bash

#SBATCH --job-name=augustus
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/index_star-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/index_star-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
refFasta="${wd}/data/GCF_932526225.1_jaNemVect1.1_genomic.fna"
od="${wd}/data/refs"
chrs=( `cut -f 1 ${refFasta}.fai` )
end=( `cut -f 2 ${refFasta}.fai` ) 

export PATH="/scratch/molevo/jmontenegro/software/bin:${PATH}"

###VARIABLES 
pos=$(( ${SLURM_ARRAY_TASK_ID} - 1 ))
chr="${chrs[$pos]}"
end="${ends[$pos]}"



###ENVIRONMENT
module load conda 
conda activate augustus
module list 

echo "Started at`date`"

echo "augustus --species=nematostella_vectensis --gff3=on --strand=both --genemodel=complete --predictionStart=${chr}:1 --predictionEnd=${chr}:end ${refFasta} > ${od}/${chr}.gff"
augustus --species=nematostella_vectensis --gff3=on --strand=both --genemodel=complete --predictionStart=${chr}:1 --predictionEnd=${chr}:end ${refFasta} > ${od}/${chr}.gff

echo "Finished at `date`"

