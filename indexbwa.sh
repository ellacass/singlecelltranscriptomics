#!/bin/bash

#SBATCH --job-name=bowtie_index
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/index_star-%j_%A.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/index_star-%j_%A.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at


###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
res="${wd}/data/results"
od="${res}/map"
refFasta=( ${wd}/data/refs/*.fasta )
read1="${wd}/data/reads/busco/SRR8101521_1.fastq"
read2="${wd}/data/reads/busco/SRR8101521_2.fastq"


###ENVIRONMENT
module load bowtie2
module load samtools
module list

###VARIABLES
ref="${refFasta[${SLURM_ARRAY_TASK_ID}]}"
idxName=`basename ${ref}`
idxName="${idxName%.*}"
outSam="SRR8101521_${idxName}.sam"
sortedBam="${outSam%.sam }.sorted.bam"

###EXECUTION
echo "Started at `date`"

echo "mkdir -p ${od}"
mkdir -p ${od}

echo "cd ${od}"
cd ${od}

echo "bowtie2-build --threads 16 ${ref} ${idxName}"
bowtie2-build --threads 16 ${ref} ${idxName}

echo "bowtie2 -x ${idxName} -1 ${read1} -2 ${read2} -p 16 --fast-local -S ${outSam}"
bowtie2 -x ${idxName} -1 ${read1} -2 ${read2} -p 16 --fast-local -S ${outSam}

echo "samtools view -u@4 ${outSam} | samtools sort -@ 16 -o ${sortedBam}"
samtools view -u@4 ${outSam} | samtools sort -@ 16 -o ${sortedBam}

echo "Finished at `date`"


