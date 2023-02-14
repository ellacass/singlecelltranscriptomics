#!/bin/bash

#SBATCH --job-name=blastp
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/blastp-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/blastp-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at

###ENVIRONMENT
module load ncbiblastplus/2.13.0 

###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
od="${wd}/data/results/blastp"
proteome=( ${wd}/data/refs/chunks/chunk*.fasta )
nr_db="/scratch/mirror/ncbi/2022-12-17/nr"
taxids="/scratch/molevo/jmontenegro/nvectensis/scripts/metazoa.taxids"

###VARIABLES
inFasta="${proteome[${SLURM_ARRAY_TASK_ID}]}"
outFile="${od}/chunk_${SLURM_ARRAY_TASK_ID}.metazoa.blastp.tsv"


###EXECUTION
echo "Started at `date`"

echo "mkdir -p ${od}"
mkdir -p ${od}

echo "blastp -query ${inFasta} -db ${nr_db} -out ${outFile} -num_threads 8 -evalue 1e-5 -taxidlist ${taxids} -outfmt 6 delim=@ qseqid sseqid ssciname salltitles evaalue bitscore qlen slen length"
blastp -query ${inFasta} -db ${nr_db} -out ${outFile} -num_threads 8 -evalue 1e-5 -taxidlist ${taxids} -outfmt "6 delim=@ qseqid sseqid ssciname salltitles evalue bitscore qlen slen length" 

echo "Finished at `date`"
