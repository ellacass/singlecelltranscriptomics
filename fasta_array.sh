#SBATCH --job-name=blastp
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G
#SBATCH --time=5:0:0
#SBATCH --partition=basic
#SBATCH --output=/scratch/students/cassidy/transcriptome/logs/blastp-%j.log
#SBATCH --error=/scratch/students/cassidy/transcriptome/logs/blastp-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=a12104717@unet.univie.ac.at



###CONSTANTS
wd="/scratch/students/cassidy/transcriptome"
od="${wd}/data/results/blastp"
proteome="${wd}/data/GHAQ01.fasta.transdecoder.pep"


samtools faidx ${proteome}
list=( `sort -k2,2R ${proteome}.fai` | cut -f 1)
for i in {0..47}
do
	start=$(( ${i} * 1127 ))
	samtools faidx ${proteome} ${list[@]:$start:1127} > chunk_${i}.fasta
done 
