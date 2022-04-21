##############plot counts with dds plotCounts##################
library(tximport)
library(DESeq2)
library(Glimma)
library(readr)
library(ggplot2)
#Larocca rat astrocytes
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab","t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)
sampleCondition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("Control","Knockdown"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds_l<-DESeq(dds)

res_l<-results(dds_l, contrast=c("condition","Knockdown","Control"))

which(rownames(res_l)=="Tardbp")

tardbp_l <- plotCounts(dds_l, gene=rownames(res_l)[15088], intgroup="condition",
                       returnData=TRUE)
pl <- ggplot(tardbp_l, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="lightgreen", colour="darkgreen", width=0.5) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="darkgreen") +
  ggtitle("Rat astrocytes") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))

#######################################################################################################
#ferguson HeLa
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp   
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab","t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)
sampleCondition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)

dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("Control","Knockdown"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds_f<-DESeq(dds)
res_f<-results(dds_f, contrast=c("condition","Knockdown","Control"))

which(rownames(res_f)=="TARDBP")
tardbp_f <- plotCounts(dds_f, gene=rownames(res_f)[19754], intgroup="condition",
                       returnData=TRUE)
pf <- ggplot(tardbp_f, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="lightpink", colour="lightpink3", width=0.5) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="lightpink3") +
  ggtitle("HeLa") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))
######################################################################################################
#Klim - ihMN
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)

datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab","t_data_c4.ctab","t_data_c5.ctab","t_data_c6.ctab",
            "t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab","t_data_k4.ctab","t_data_k5.ctab","t_data_k6.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)
sampleCondition=c("Control","Control","Control","Control","Control","Control","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown")
sampleSubject=c("P1","P2","P3","P4","P5","P6","P1","P2","P3","P4","P5","P6")
sampleTable = data.frame(condition=sampleCondition, subject=sampleSubject)
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
dds<-DESeq(dds)
ddsMF <- dds
ddsMF$subject <- as.factor(ddsMF$subject)
design(ddsMF) <- formula(~ subject + condition)
ddsMF <- DESeq(ddsMF)
resMF <- results(ddsMF)

which(rownames(resMF)=="TARDBP")
tardbp <- plotCounts(ddsMF, gene=rownames(resMF)[26440], intgroup="condition",
                     returnData=TRUE)
pk <- ggplot(tardbp, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="orchid", colour="orchid4", width=0.5) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="orchid4")+
  ggtitle("ihMN") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))

#paired
library("ggbeeswarm")
tdp <- plotCounts(ddsMF, gene=rownames(resMF)[26440], intgroup = c("condition","subject"),
                  returnData=TRUE)
ggplot(tdp, aes(x = condition, y = count, color = subject, group = subject)) +
  scale_y_log10() + geom_point(size = 3) + geom_line()
##########################################################################################
#melamed SHSY5Y
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp   
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab","t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)
sampleCondition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)

sampleCondition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)

dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("Control","Knockdown"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds_m<-DESeq(dds)
res_m<-results(dds_m, contrast=c("condition","Knockdown","Control"))

which(rownames(res_m)=="TARDBP")

tardbp_m <- plotCounts(dds_m, gene=rownames(res_m)[22305], intgroup="condition",
                       returnData=TRUE)
pm <- ggplot(tardbp_m, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="violetred", colour="violetred4", width=0.5)+
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="violetred4") +
  ggtitle("SH-SY5Y") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))
###############################################################################################
#polymenidou mouse stiatum 
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp   
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab",
            "t_data_c4.ctab","t_data_c5.ctab","t_data_c6.ctab",
            "t_data_c7.ctab","t_data_c8.ctab","t_data_c9.ctab",
            "t_data_c10.ctab","t_data_c11.ctab",
            "t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab",
            "t_data_k4.ctab","t_data_k5.ctab","t_data_k6.ctab",
            "t_data_k7.ctab","t_data_k8.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)


sampleCondition=c("Control","Control","Control","Control","Control","Control","Control","Control","Control","Control","Control","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("Control","Knockdown"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds_p<-DESeq(dds)
res_p<-results(dds_p, contrast=c("condition","Knockdown","Control"))
which(rownames(res_p)=="Tardbp")
tardbp_p <- plotCounts(dds_p, gene=rownames(res_p)[24395], intgroup="condition",
                       returnData=TRUE)
pp <- ggplot(tardbp_p, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="turquoise", colour="turquoise4", width=0.5)+
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="turquoise4") +
  ggtitle("Mouse striatum") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))
################################################################################################
#zhao mouse mammary
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp   
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab","t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab","t_data_k4.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)

sampleCondition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown","Knockdown")
sampleTable = data.frame(condition=sampleCondition)
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("Control","Knockdown"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds_z<-DESeq(dds)
res_z<-results(dds_z, contrast=c("condition","Knockdown","Control"))
which(rownames(res_z)=="Tardbp")
tardbp_z <- plotCounts(dds_z, gene=rownames(res_z)[23144], intgroup="condition",
                       returnData=TRUE)
pz <- ggplot(tardbp_z, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="skyblue", colour="skyblue4", width=0.5)+
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="skyblue4") +
  ggtitle("Mouse mammary gland") + xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))

################################################################################################
#liu - TDPneg and TDPpos 
#setwd to ctab files
tmp=readr::read_tsv("t_data_c1.ctab")
tmp   
tx2gene = tmp[, c("t_name", "gene_name")]
head(tx2gene)
datafiles=c("t_data_c1.ctab","t_data_c2.ctab","t_data_c3.ctab",
            "t_data_c4.ctab","t_data_c5.ctab","t_data_c6.ctab",
            "t_data_c7.ctab",
            "t_data_k1.ctab","t_data_k2.ctab","t_data_k3.ctab",
            "t_data_k4.ctab","t_data_k5.ctab","t_data_k6.ctab",
            "t_data_k7.ctab")
txi <- tximport(datafiles, type = "stringtie", tx2gene = tx2gene)

sampleCondition=c("TDP_pos","TDP_pos","TDP_pos","TDP_pos","TDP_pos","TDP_pos","TDP_pos","TDP_neg","TDP_neg","TDP_neg","TDP_neg","TDP_neg","TDP_neg","TDP_neg")
sampleSubject=c("P1","P2","P3","P4","P5","P6","P7","P1","P2","P3","P4","P5","P6","P7")
sampleTable = data.frame(condition=sampleCondition, subject=sampleSubject)
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds$condition <- factor(dds$condition, levels = c("TDP_pos","TDP_neg"))
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds<-DESeq(dds)
res<-results(dds, contrast=c("condition","TDP_neg","TDP_pos"))
resOrdered <- res[order(res$padj),]

ddsMF_l <- dds
ddsMF_l$subject <- as.factor(ddsMF_l$subject)
design(ddsMF_l) <- formula(~ subject + condition)
ddsMF_l <- DESeq(ddsMF_l)

resMF_l<-results(ddsMF_l)

which(rownames(resMF_l)=="TARDBP")
tardbp_l <- plotCounts(ddsMF_l, gene=rownames(resMF_l)[35556], intgroup="condition",
                       returnData=TRUE)
pL <- ggplot(tardbp_l, aes(x=condition, y=count)) +
  ylim(0, NA) +
  geom_boxplot(fill="grey", colour="grey4", width=0.5)+
  geom_dotplot(binaxis='y', stackdir='center', dotsize=0.5, fill="grey4")+
  ggtitle("NeuN positive nuclei") +xlab("") + ylab("Normalized Count")+
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),text = element_text(size=12))
################################################################################################