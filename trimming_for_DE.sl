#!/bin/bash -e
#SBATCH --job-name=Trimming # job name (shows up in the queue)
#SBATCH --time=10:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=10000MB          # Memory in MB
#SBATCH --cpus-per-task=16

#######################
#Ferguson_HeLa
#######################
module load Trimmomatic/0.39-Java-1.8.0_144
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045016_1.fastq SRR10045016_2.fastq  \
              SRR10045016_1.trimmed.fastq SRR10045016_1un.trimmed.fastq \
              SRR10045016_2.trimmed.fastq SRR10045016_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045017_1.fastq SRR10045016_2.fastq  \
              SRR10045017_1.trimmed.fastq SRR10045017_1un.trimmed.fastq \
              SRR10045017_2.trimmed.fastq SRR10045017_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045018_1.fastq SRR10045016_2.fastq  \
              SRR10045018_1.trimmed.fastq SRR10045018_1un.trimmed.fastq \
              SRR10045018_2.trimmed.fastq SRR10045018_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045019_1.fastq SRR10045016_2.fastq  \
              SRR10045019_1.trimmed.fastq SRR10045019_1un.trimmed.fastq \
              SRR10045019_2.trimmed.fastq SRR10045019_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045020_1.fastq SRR10045016_2.fastq  \
              SRR10045020_1.trimmed.fastq SRR10045020_1un.trimmed.fastq \
              SRR10045020_2.trimmed.fastq SRR10045020_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic PE -threads $SLURM_CPUS_PER_TASK -phred33 \
              SRR10045021_1.fastq SRR10045016_2.fastq  \
              SRR10045021_1.trimmed.fastq SRR10045021_1un.trimmed.fastq \
              SRR10045021_2.trimmed.fastq SRR10045021_2un.trimmed.fastq \
             SLIDINGWINDOW:4:30 MINLEN:50

#######################
#Polymenidou_m.str
#######################
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107061.fastq \
            SRR107061.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107062.fastq \
            SRR107062.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107063.fastq \
            SRR107063.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107064.fastq \
            SRR107064.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107065.fastq \
            SRR107065.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107066.fastq \
            SRR107066.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107067.fastq \
            SRR107067.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107068.fastq \
            SRR107068.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107069.fastq \
            SRR107069.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107070.fastq \
            SRR107070.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107071.fastq \
            SRR107071.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107074.fastq \
            SRR107074.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107075.fastq \
            SRR107075.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107076.fastq \
            SRR107076.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107077.fastq \
            SRR107077.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107078.fastq \
            SRR107078.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107079.fastq \
            SRR107079.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107080.fastq \
            SRR107080.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR107081.fastq \
            SRR107081.trimmed.fastq \
            ILLUMINACLIP:TruSeq2-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:50

#######################
#Larocca_r.ast
#######################
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937050.fastq \
            SRR9937050.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937051.fastq \
            SRR9937051.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937052.fastq \
            SRR9937052.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937053.fastq \
            SRR9937053.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937054.fastq \
            SRR9937054.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80
trimmomatic SE -threads $SLURM_CPUS_PER_TASK -phred33 \
            SRR9937055.fastq \
            SRR9937055.trimmed.fastq \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 SLIDINGWINDOW:4:30 MINLEN:80

