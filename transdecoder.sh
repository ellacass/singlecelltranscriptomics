#!/bin/bash


#SBATCH --job-name=transdecoder
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/transdecoder-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/transdecoder-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
res="${wd}/results"
od="${res}/dedup"
inFasta="${wd}/data/refs/GHAQ01.renamed.fasta"
outFile="${od}/cd_hit_result"
outTransdecoder="${od}/decoded"

###ENVIRONMEN
module load transdecoder
module load cdhit

### VARIABLES
###none 

###first command with CD-hit
echo "Started a `date`"

echo "mkdir -p ${od}"
mkdir -p ${od}

echo "cd-hit-est i ${inFasta} -o ${od}/cd_hit_result -c 1 -T 8 -d 50"
cd-hit-est -i ${inFasta} -o ${od}/cd_hit_result -c 1 -T 8 -d 50 -aS 1

echo "TransDecoder.LongOrfs -t ${outFile} --output_dir ${outTransdecoder}"
TransDecoder.LongOrfs -t ${outFile} -S -O ${outTransdecoder} 


echo "TransDecoder.Predict -t ${outFile} --output_dir ${outTranscoder}"
TransDecoder.Predict -t ${outFile} --single_best_only -O ${outTransdecoder}

echo "Finished at `date`"
