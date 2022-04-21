#!/bin/bash -e
#SBATCH --job-name=MappingAssembly # job name (shows up in the queue)
#SBATCH --time=20:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=10000MB          # Memory in MB
#SBATCH --cpus-per-task=16

#######################
#Ferguson_HeLa
#######################
module load HISAT2/2.2.1-gimkl-2020a
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045016_1.trimmed.fastq -2 SRR10045016_2.trimmed.fastq -S ferg_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045017_1.trimmed.fastq -2 SRR10045017_2.trimmed.fastq -S ferg_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045018_1.trimmed.fastq -2 SRR10045018_2.trimmed.fastq -S ferg_kd_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045019_1.trimmed.fastq -2 SRR10045019_2.trimmed.fastq -S ferg_con_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045020_1.trimmed.fastq -2 SRR10045020_2.trimmed.fastq -S ferg_con_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR10045021_1.trimmed.fastq -2 SRR10045021_2.trimmed.fastq -S ferg_con_3.sam 

module load SAMtools/1.13-GCC-9.2.0
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_con_1.bam ferg_con_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_con_2.bam ferg_con_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_con_3.bam ferg_con_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_kd_1.bam ferg_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_kd_2.bam ferg_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o ferg_kd_3.bam ferg_kd_3.sam &&

module load StringTie/1.3.5-gimkl-2018b
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_con_1 -o ferg_con_1.gtf ferg_con_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_con_2 -o ferg_con_2.gtf ferg_con_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_con_3 -o ferg_con_3.gtf ferg_con_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_kd_1 -o ferg_kd_1.gtf ferg_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_kd_2 -o ferg_kd_2.gtf ferg_kd_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l ferg_kd_3 -o ferg_kd_3.gtf ferg_kd_3.bam 

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_merged.gtf ferg_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_con_1/ferg_merged.gtf ferg_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_con_2/ferg_merged.gtf ferg_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_con_3/ferg_merged.gtf ferg_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_kd_1/ferg_merged.gtf ferg_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_kd_2/ferg_merged.gtf ferg_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o ferg_kd_3/ferg_merged.gtf ferg_kd_3.bam &&


#######################
#Melamed_SHSY5Y
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144907.fastq -S melamed_con_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144908.fastq -S melamed_con_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144909.fastq -S melamed_con_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144910.fastq -S melamed_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144911.fastq -S melamed_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -U SRR8144912.fastq -S melamed_kd_3.sam

samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_1.bam melamed_con_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_2.bam melamed_con_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_3.bam melamed_con_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_1.bam melamed_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_2.bam melamed_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o melamed_con_3.bam melamed_kd_3.sam 

stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_con_1 -o melamed_con_1.gtf melamed_con_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_con_2 -o melamed_con_2.gtf melamed_con_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_con_3 -o melamed_con_3.gtf melamed_con_3.bam && 
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_kd_1 -o melamed_kd_1.gtf melamed_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_kd_2 -o melamed_kd_2.gtf melamed_kd_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l melamed_kd_3 -o melamed_kd_3.gtf melamed_kd_3.bam &&

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_merged.gtf melamed_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_con_1/melamed_merged.gtf melamed_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_con_2/melamed_merged.gtf melamed_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_con_3/melamed_merged.gtf melamed_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_kd_1/melamed_merged.gtf melamed_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_kd_2/melamed_merged.gtf melamed_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o melamed_kd_3/melamed_merged.gtf melamed_kd_3.bam

#######################
#Klim_ihMN
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083865_1.fastq -2 SRR8083865_2.fastq -S klim_con_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083866_1.fastq -2 SRR8083866_2.fastq -S klim_con_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083867_1.fastq -2 SRR8083867_2.fastq -S klim_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083868_1.fastq -2 SRR8083868_2.fastq -S klim_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083872_1.fastq -2 SRR8083872_2.fastq -S klim_con_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083873_1.fastq -2 SRR8083873_2.fastq -S klim_con_4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083874_1.fastq -2 SRR8083874_2.fastq -S klim_kd_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083875_1.fastq -2 SRR8083875_2.fastq -S klim_kd_4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083878_1.fastq -2 SRR8083878_2.fastq -S klim_con_5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083879_1.fastq -2 SRR8083879_2.fastq -S klim_con_6.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083880_1.fastq -2 SRR8083880_2.fastq -S klim_kd_5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8083881_1.fastq -2 SRR8083881_2.fastq -S klim_kd_6.sam

samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_1.bam klim_con_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_2.bam klim_con_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_3.bam klim_con_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_4.bam klim_con_4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_5.bam klim_con_5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_con_6.bam klim_con_6.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_1.bam klim_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_2.bam klim_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_3.bam klim_kd_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_4.bam klim_kd_4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_5.bam klim_kd_5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o klim_kd_6.bam klim_kd_6.sam

stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_1 -o klim_con_1.gtf klim_con_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_2 -o klim_con_2.gtf klim_con_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_3 -o klim_con_3.gtf klim_con_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_4 -o klim_con_4.gtf klim_con_4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_5 -o klim_con_5.gtf klim_con_5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_6 -o klim_con_6.gtf klim_con_6.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_7 -o klim_con_7.gtf klim_con_7.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_8 -o klim_con_8.gtf klim_con_8.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_con_9 -o klim_con_9.gtf klim_con_9.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_1 -o klim_kd_1.gtf klim_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_2 -o klim_kd_2.gtf klim_kd_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_3 -o klim_kd_3.gtf klim_kd_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_4 -o klim_kd_4.gtf klim_kd_4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_5 -o klim_kd_5.gtf klim_kd_5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l klim_kd_6 -o klim_kd_6.gtf klim_kd_6.bam

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_merged.gtf klim_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_1/klim_merged.gtf klim_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_2/klim_merged.gtf klim_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_3/klim_merged.gtf klim_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_4/klim_merged.gtf klim_con_4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_5/klim_merged.gtf klim_con_5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_6/klim_merged.gtf klim_con_6.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_7/klim_merged.gtf klim_con_7.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_8/klim_merged.gtf klim_con_8.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_con_9/klim_merged.gtf klim_con_9.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_1/klim_merged.gtf klim_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_2/klim_merged.gtf klim_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_3/klim_merged.gtf klim_kd_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_4/klim_merged.gtf klim_kd_4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_5/klim_merged.gtf klim_kd_5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o klim_kd_6/klim_merged.gtf klim_kd_6.bam


#######################
#Polymenidou_m.str
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107061.trimmed.fastq -S poly_con_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107062.trimmed.fastq -S poly_con_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107063.trimmed.fastq -S poly_con_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107064.trimmed.fastq -S poly_con_4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107065.trimmed.fastq -S poly_con_5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107066.trimmed.fastq -S poly_con_6.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107067.trimmed.fastq -S poly_con_7.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107068.trimmed.fastq -S poly_con_8.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107069.trimmed.fastq -S poly_con_9.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107070.trimmed.fastq -S poly_con_10.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107071.trimmed.fastq -S poly_con_11.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107074.trimmed.fastq -S poly_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107075.trimmed.fastq -S poly_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107076.trimmed.fastq -S poly_kd_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107077.trimmed.fastq -S poly_kd_4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107078.trimmed.fastq -S poly_kd_5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107079.trimmed.fastq -S poly_kd_6.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107080.trimmed.fastq -S poly_kd_7.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -U SRR107081.trimmed.fastq -S poly_kd_8.sam

samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_1.bam poly_con_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_2.bam poly_con_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_3.bam poly_con_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_4.bam poly_con_4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_5.bam poly_con_5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_6.bam poly_con_6.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_7.bam poly_con_7.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_8.bam poly_con_8.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_9.bam poly_con_9.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_10.bam poly_con_10.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_con_11.bam poly_con_11.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_1.bam poly_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_2.bam poly_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_3.bam poly_kd_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_4.bam poly_kd_4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_5.bam poly_kd_5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_6.bam poly_kd_6.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_7.bam poly_kd_7.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o poly_kd_8.bam poly_kd_8.sam 

stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_1 -o poly_con_1.gtf poly_con_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_2 -o poly_con_2.gtf poly_con_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_3 -o poly_con_3.gtf poly_con_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_4 -o poly_con_4.gtf poly_con_4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_5 -o poly_con_5.gtf poly_con_5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_6 -o poly_con_6.gtf poly_con_6.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_7 -o poly_con_7.gtf poly_con_7.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_8 -o poly_con_8.gtf poly_con_8.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_9 -o poly_con_9.gtf poly_con_9.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_10 -o poly_con_10.gtf poly_con_10.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_con_11 -o poly_con_11.gtf poly_con_11.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_1 -o poly_kd_1.gtf poly_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_2 -o poly_kd_2.gtf poly_kd_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_3 -o poly_kd_3.gtf poly_kd_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_4 -o poly_kd_4.gtf poly_kd_4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_5 -o poly_kd_5.gtf poly_kd_5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_6 -o poly_kd_6.gtf poly_kd_6.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_7 -o poly_kd_7.gtf poly_kd_7.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l  poly_kd_8 -o poly_kd_8.gtf poly_kd_8.bam

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_merged.gtf  poly_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_1/poly_merged.gtf  poly_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_2/poly_merged.gtf  poly_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_3/poly_merged.gtf  poly_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_4/poly_merged.gtf  poly_con_4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_5/poly_merged.gtf  poly_con_5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_6/poly_merged.gtf  poly_con_6.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_7/poly_merged.gtf  poly_con_7.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_8/poly_merged.gtf  poly_con_8.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_9/poly_merged.gtf  poly_con_9.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_10/poly_merged.gtf  poly_con_10.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_con_11/poly_merged.gtf  poly_con_11.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_1/poly_merged.gtf  poly_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_2/poly_merged.gtf  poly_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_3/poly_merged.gtf  poly_kd_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_4/poly_merged.gtf  poly_kd_4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_5/poly_merged.gtf  poly_kd_5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_6/poly_merged.gtf  poly_kd_6.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_7/poly_merged.gtf  poly_kd_7.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o  poly_kd_8/poly_merged.gtf  poly_kd_8.bam

#######################
#Zhao_m.mam
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455808_1.fastq -2  SRR7455808_2.fastq -S zhao_control_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455809_1.fastq -2  SRR7455809_2.fastq -S zhao_control_2.sam&&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455810_1.fastq -2  SRR7455810_2.fastq -S zhao_control_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455811_1.fastq -2  SRR7455811_2.fastq -S zhao_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455812_1.fastq -2  SRR7455812_2.fastq -S zhao_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455813_1.fastq -2  SRR7455813_2.fastq -S zhao_kd_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Mmusculus --dta -1  SRR7455814_1.fastq -2  SRR7455814_2.fastq -S zhao_kd_4.sam

samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_control_1.bam zhao_control_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_control_2.bam zhao_control_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_control_3.bam zhao_control_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_kd_1.bam zhao_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_kd_2.bam zhao_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_kd_3.bam zhao_kd_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o zhao_kd_4.bam zhao_kd_4.sam

stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_control_1 -o zhao_control_1.gtf zhao_control_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_control_2 -o zhao_control_2.gtf zhao_control_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_control_3 -o zhao_control_3.gtf zhao_control_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_kd_1 -o zhao_kd_1.gtf zhao_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_kd_2 -o zhao_kd_2.gtf zhao_kd_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_kd_3 -o zhao_kd_3.gtf zhao_kd_3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -l zhao_kd_4 -o zhao_kd_4.gtf zhao_kd_4.bam

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_merged.gtf zhao_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_con_1/zhao_merged.gtf zhao_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_con_2/zhao_merged.gtf zhao_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_con_3/zhao_merged.gtf zhao_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_kd_1/zhao_merged.gtf zhao_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_kd_2/zhao_merged.gtf zhao_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_kd_3/zhao_merged.gtf zhao_kd_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Mus_musculus.GRCm38.101.gtf -o zhao_kd_4/zhao_merged.gtf zhao_kd_4.bam

#######################
#Larocca_r.ast
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937050.trimmed.fastq -S larocca_con_1.sam && 
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937051.trimmed.fastq -S larocca_con_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937052.trimmed.fastq -S larocca_con_3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937053.trimmed.fastq -S larocca_kd_1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937054.trimmed.fastq -S larocca_kd_2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x Rnorvegicus --dta -U SRR9937055.trimmed.fastq -S larocca_kd_3.sam

samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_con_1.bam larocca_con_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_con_2.bam larocca_con_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_con_3.bam larocca_con_3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_kd_1.bam larocca_kd_1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_kd_2.bam larocca_kd_2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o larocca_kd_3.bam larocca_kd_3.sam

stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_con_1 -o larocca_con_1.gtf larocca_con_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_con_2 -o larocca_con_2.gtf larocca_con_2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_con_3 -o larocca_con_3.gtf larocca_con_3.bam && 
stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_kd_1 -o larocca_kd_1.gtf larocca_kd_1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_kd_2 -o larocca_kd_2.gtf larocca_kd_2.bam && 
stringtie -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.104.gtf -l larocca_kd_3 -o larocca_kd_3.gtf larocca_kd_3.bam 

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_merged.gtf larocca_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_con_1/larocca_merged.gtf larocca_con_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_con_2/larocca_merged.gtf larocca_con_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_con_3/larocca_merged.gtf larocca_con_3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_kd_1/larocca_merged.gtf larocca_kd_1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_kd_2/larocca_merged.gtf larocca_kd_2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Rattus_norvegicus.Rnor_6.0.101.gtf -o larocca_kd_3/larocca_merged.gtf larocca_kd_3.bam

#######################
#Liu_TDPneg
#######################
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571937_1.trimmed.fastq -2 SRR8571937_2.trimmed.fastq -S TDPpos1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571938_1.trimmed.fastq -2 SRR8571938_2.trimmed.fastq -S TDPneg1.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571939_1.trimmed.fastq -2 SRR8571939_2.trimmed.fastq -S TDPpos2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571940_1.trimmed.fastq -2 SRR8571940_2.trimmed.fastq -S TDPneg2.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571941_1.trimmed.fastq -2 SRR8571941_2.trimmed.fastq -S TDPpos3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571942_1.trimmed.fastq -2 SRR8571942_2.trimmed.fastq -S TDPneg3.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571944_1.trimmed.fastq -2 SRR8571944_2.trimmed.fastq -S TDPpos4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571945_1.trimmed.fastq -2 SRR8571945_2.trimmed.fastq -S TDPneg4.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571947_1.trimmed.fastq -2 SRR8571947_2.trimmed.fastq -S TDPpos5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571948_1.trimmed.fastq -2 SRR8571948_2.trimmed.fastq -S TDPneg5.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571949_1.trimmed.fastq -2 SRR8571949_2.trimmed.fastq -S TDPpos6.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571950_1.trimmed.fastq -2 SRR8571950_2.trimmed.fastq -S TDPneg6.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571951_1.trimmed.fastq -2 SRR8571951_2.trimmed.fastq -S TDPneg7.sam &&
hisat2 -p $SLURM_CPUS_PER_TASK -x HSapien --dta -1 SRR8571952_1.trimmed.fastq -2 SRR8571952_2.trimmed.fastq -S TDPneg7.sam 

samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos1.bam TDPpos1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos2.bam TDPpos2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos3.bam TDPpos3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos4.bam TDPpos4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos5.bam TDPpos5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos6.bam TDPpos6.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPpos7.bam TDPpos7.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg1.bam TDPneg1.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg2.bam TDPneg2.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg3.bam TDPneg3.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg4.bam TDPneg4.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg5.bam TDPneg5.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg6.bam TDPneg6.sam &&
samtools sort -@ $SLURM_CPUS_PER_TASK -o TDPneg7.bam TDPneg7.sam

stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos1 -o TDPpos1.gtf TDPpos1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos2 -o TDPpos2.gtf TDPpos2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos3 -o TDPpos3.gtf TDPpos3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos4 -o TDPpos4.gtf TDPpos4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos5 -o TDPpos5.gtf TDPpos5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos6 -o TDPpos6.gtf TDPpos6.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPpos7 -o TDPpos7.gtf TDPpos7.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg1 -o TDPneg1.gtf TDPneg1.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg2 -o TDPneg2.gtf TDPneg2.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg3 -o TDPneg3.gtf TDPneg3.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg4 -o TDPneg4.gtf TDPneg4.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg5 -o TDPneg5.gtf TDPneg5.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg6 -o TDPneg6.gtf TDPneg6.bam &&
stringtie -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -l TDPneg7 -o TDPneg7.gtf TDPneg7.bam

stringtie --merge -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o liu_merged.gtf liu_mergelist.txt

stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos1/liu_merged.gtf TDPpos1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos2/liu_merged.gtf TDPpos2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos3/liu_merged.gtf TDPpos3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos4/liu_merged.gtf TDPpos4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos5/liu_merged.gtf TDPpos5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos6/liu_merged.gtf TDPpos6.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPpos7/liu_merged.gtf TDPpos7.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg1/liu_merged.gtf TDPneg1.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg2/liu_merged.gtf TDPneg2.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg3/liu_merged.gtf TDPneg3.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg4/liu_merged.gtf TDPneg4.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg5/liu_merged.gtf TDPneg5.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg6/liu_merged.gtf TDPneg6.bam &&
stringtie -e -B -p $SLURM_CPUS_PER_TASK -G Homo_sapiens.GRCh38.93.gtf -o TDPneg7/liu_merged.gtf TDPneg7.bam
