############
#  DEXSeq  #
############

#load packages
library(GenomicRanges)
library(GenomicFeatures)
library(GenomicAlignments)
library(DEXSeq)
library(RMariaDB)
library(biomaRt)
library(BiocParallel)
library(Rsamtools)


hse <- makeTxDbFromEnsembl(organism="Homo sapiens",
                           release=NA,
                           circ_seqs=NULL,
                           server="ensembldb.ensembl.org",
                           username="anonymous", password=NULL, port=0L,
                           tx_attrib=NULL)

exonicParts = exonicParts( hse, linked.to.single.gene.only = TRUE )
bamfiles <- dir(".", "bam$")
bamlst = BamFileList( bamfiles, index=character(), yieldSize=100000, obeyQname=TRUE )
SE = summarizeOverlaps( exonicParts, bamlst, mode="Union", singleEnd=FALSE, ignore.strand=TRUE, inter.feature=FALSE, fragments=TRUE )


#Create DEXSeqDataSet
colData(SE)$condition=c("Control","Control","Control","Knockdown","Knockdown","Knockdown")
DEXSeqDataSetFromSE(SE, design= ~ sample + exon + condition:exon )
dxd = DEXSeqDataSetFromSE(SE, design= ~ sample + exon + condition:exon)

#Run exon usage analysis
dxr = DEXSeq(dxd, BPPARAM=BPPARAM)

#Generate csv
dxrOrdered <- dxr[order(dxr$pvalue),]
dxrSig <- subset(dxrOrdered, padj < 0.05)
write.csv(as.data.frame(dxrSig),
          file="ferguson_exon_significant.csv")


#Generate html report
mart <- useMart("ensembl", dataset="hsapiens_gene_ensembl")
attributes <- c("external_gene_name", "description")
filter="ensembl_gene_id"

DEXSeqHTML(dxr, genes=NULL, path="HeLaDEXSeq", file="Hela.html",
           fitExpToVar="condition", FDR=0.05, color=c("#0000FF80","#FF000080"),
           mart=mart, filter="", attributes=attributes, extraCols=NULL)