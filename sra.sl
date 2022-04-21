#!/bin/bash -e
#SBATCH --job-name=SRAtoolkit # job name (shows up in the queue)
#SBATCH --time=10:00:00      # Walltime (HH:MM:SS)
#SBATCH --mem=3000MB          # Memory in MB

#######################
#Ferguson_HeLa
#######################
module load sratoolkit/2.9.6
fasterq-dump -S SRR10045016 #siTDP
fasterq-dump -S SRR10045017 #siTDP
fasterq-dump -S SRR10045018 #siTDP
fasterq-dump -S SRR10045019 #scr
fasterq-dump -S SRR10045020 #scr
fasterq-dump -S SRR10045021 #scr

#######################  
#Melamed_SHSY5Y
#######################
fasterq-dump -S SRR8144907 #scr
fasterq-dump -S SRR8144908 #scr
fasterq-dump -S SRR8144909 #scr
fasterq-dump -S SRR8144910 #siTDP
fasterq-dump -S SRR8144911 #siTDP
fasterq-dump -S SRR8144912 #siTDP

#######################
#Klim_ihMN
#######################
fasterq-dump -S SRR8083865 #scr
fasterq-dump -S SRR8083866 #scr
fasterq-dump -S SRR8083867 #siTDP
fasterq-dump -S SRR8083868 #siTDP
fasterq-dump -S SRR8083872 #scr
fasterq-dump -S SRR8083873 #scr
fasterq-dump -S SRR8083874 #siTDP
fasterq-dump -S SRR8083875 #siTDP
fasterq-dump -S SRR8083878 #scr
fasterq-dump -S SRR8083879 #scr
fasterq-dump -S SRR8083880 #siTDP
fasterq-dump -S SRR8083881 #siTDP

#######################
#Polymenidou_m.str
#######################
fasterq-dump -S SRR107061 #con
fasterq-dump -S SRR107062 #con
fasterq-dump -S SRR107063 #con
fasterq-dump -S SRR107064 #con
fasterq-dump -S SRR107065 #con
fasterq-dump -S SRR107066 #con
fasterq-dump -S SRR107067 #con
fasterq-dump -S SRR107068 #con
fasterq-dump -S SRR107069 #con
fasterq-dump -S SRR107070 #con
fasterq-dump -S SRR107071 #con
fasterq-dump -S SRR107072 #TDPKO
fasterq-dump -S SRR107073 #TDPKO
fasterq-dump -S SRR107074 #TDPKO
fasterq-dump -S SRR107075 #TDPKO
fasterq-dump -S SRR107076 #TDPKO
fasterq-dump -S SRR107077 #TDPKO
fasterq-dump -S SRR107078 #TDPKO
fasterq-dump -S SRR107079 #TDPKO
fasterq-dump -S SRR107080 #TDPKO
fasterq-dump -S SRR107081 #TDPKO

#######################
#Zhao_m.mam
#######################
fasterq-dump -S SRR7455808 #wt
fasterq-dump -S SRR7455809 #wt
fasterq-dump -S SRR7455810 #wt
fasterq-dump -S SRR7455811 #TDPKO
fasterq-dump -S SRR7455812 #TDPKO
fasterq-dump -S SRR7455813 #TDPKO
fasterq-dump -S SRR7455814 #TDPKO

#######################
#Larocca_r.ast
#######################
fasterq-dump -S SRR9937050 #scr
fasterq-dump -S SRR9937051 #scr
fasterq-dump -S SRR9937052 #scr
fasterq-dump -S SRR9937053 #siTDP
fasterq-dump -S SRR9937054 #siTDP
fasterq-dump -S SRR9937055 #siTDP

#######################
#Liu_TDPneg
#######################
fasterq-dump -S SRR8571937 #TDPpos
fasterq-dump -S SRR8571938 #TDPneg
fasterq-dump -S SRR8571939 #TDPpos
fasterq-dump -S SRR8571940 #TDPneg
fasterq-dump -S SRR8571941 #TDPpos
fasterq-dump -S SRR8571942 #TDPneg
fasterq-dump -S SRR8571944 #TDPpos
fasterq-dump -S SRR8571945 #TDPneg
fasterq-dump -S SRR8571947 #TDPpos
fasterq-dump -S SRR8571948 #TDPneg
fasterq-dump -S SRR8571949 #TDPpos
fasterq-dump -S SRR8571950 #TDPneg
fasterq-dump -S SRR8571951 #TDPpos
fasterq-dump -S SRR8571952 #TDPneg
