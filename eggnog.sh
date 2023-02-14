#!/bin/bash

#SBATCH --job-name=eggnog
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/eggnog-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/eggnog-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###ENVIRONMENT
module load conda
module list
conda activate eggnog-mapper-2.1.9

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
od="${wd}/data/results/eggnog"
proteome="${wd}/data/GHAQ01.fasta.transdecoder.pep"
data="/scratch/mirror/eggnog-mapper/2.1.9"



###EXECUTION
echo "Started at `date`"

echo "emapper.py --cpu 16 -i ${proteome} --itype proteins --data_dir ${data} -m diamond --go_evidence add --output GHAQ_eggnog"
emapper.py --cpu 16 -i ${proteome} --itype proteins --data_dir ${data} -m diamond --go_evidence all --output GHAQ_eggnog --output_dir ${od}

echo "Finished at `date`"
