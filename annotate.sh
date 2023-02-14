#!/bin/bash

#SBATCH --job-name=interpro
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/interpro-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/interpro-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at



###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
od="${wd}/data/results/ips"
proteome="${wd}/data/GHAQ01.fasta.transdecoder.pep"
ips="/scratch/mirror/interpro/interproscan-5.60-92.0/interproscan.sh"

###VARIABLES


###EXECUTION
echo "mkdir -p {od}"
mkdir -p {od}

echo "bash ${ips} -i ${proteome} -cpu 16 -d -f tsv,gff3 -b ${od} -t n|p -goterms"
bash ${ips} -i ${proteome} -cpu 16 -f tsv,gff3 -b ${od} -t p -goterms -pa
