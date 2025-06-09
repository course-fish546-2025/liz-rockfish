#!/bin/bash
#SBATCH --job-name=process_radtags_newdemux2
#SBATCH --account=merlab
#SBATCH --partition=compute-hugemem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-12:00:00
## Memory per node
#SBATCH --mem=500G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lizboggs@uw.edu

### This script runs through indexed library fastq.gz files in order to demultiplex to the individual sample level ###


##### ENVIRONMENT SETUP ##########
## Specify the directory containing data
RAWDIR=/mmfs1/gscratch/merlab/lizboggs/rawrad_demuxlibs/demux.2025-05-14.maybe_final
OUTDIR=/mmfs1/gscratch/scrubbed/lizboggs/demux_by_lib_freshrun060325
BARCODES=/gscratch/merlab/lizboggs/barcodes
MYCONDA=/gscratch/merlab/software/miniconda3/etc/profile.d/conda.sh
MYENV=stacks_env

mkdir -p $OUTDIR

## start with clean slate
module purge

## This is the filepath to our conda installation on Klone. Source command will allow us to execute commands from a file in the current shell
source $MYCONDA

## activate the conda environment
conda activate $MYENV

##################### PLATE 01: LIB INDEX ATCACG #######################################################################

### Separates raw sequencing files into individual IDs based on matching barcodes

process_radtags \
-1 ${RAWDIR}/ATCACG_S3_L003_R1_001.fastq.gz \
-2 ${RAWDIR}/ATCACG_S3_L003_R2_001.fastq.gz \
-o $OUTDIR \
-b $BARCODES/rflib01_barcodes_withlib.txt \
--inline_index \
-i gzfastq \
-y fastq \
-E phred33 \
--bestrad \
-e sbfI \
-q \
--filter_illumina \
-c \
-t 130 \
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-r \
--barcode_dist_1 1 \
--barcode_dist_2 1 \

##################### PLATE 02: LIB INDEX CGATGT #######################################################################

### Separates raw sequencing files into individual IDs based on matching barcodes

process_radtags \
-1 ${RAWDIR}/CGATGT_S2_L003_R1_001.fastq.gz \
-2 ${RAWDIR}/CGATGT_S2_L003_R2_001.fastq.gz \
-o $OUTDIR \
-b $BARCODES/rflib02_barcodes_withlib.txt \
--inline_index \
-i gzfastq \
-y fastq \
-E phred33 \
--bestrad \
-e sbfI \
-q \
--filter_illumina \
-c \
-t 130 \
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-r \
--barcode_dist_1 1 \
--barcode_dist_2 1 \

##################### PLATE 03: LIB INDEX TTAGGC #######################################################################

### Separates raw sequencing files into individual IDs based on matching barcodes

process_radtags \
-1 ${RAWDIR}/TTAGGC_S1_L003_R1_001.fastq.gz \
-2 ${RAWDIR}/TTAGGC_S1_L003_R2_001.fastq.gz \
-o $OUTDIR \
-b $BARCODES/rflib03_barcodes_withlib.txt \
--inline_index \
-i gzfastq \
-y fastq \
-E phred33 \
--bestrad \
-e sbfI \
-q \
--filter_illumina \
-c \
-t 130 \
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-r \
--barcode_dist_1 1 \
--barcode_dist_2 1 \

################## PLATE 04: LIB INDEX TGACCA ##########################################################################

### Separates raw sequencing files into individual IDs based on matching barcodes

process_radtags \
-1 ${RAWDIR}/TGACCA_S4_L003_R1_001.fastq.gz \
-2 ${RAWDIR}/TGACCA_S4_L003_R2_001.fastq.gz \
-o $OUTDIR \
-b $BARCODES/rflib04_barcodes_withlib.txt \
--inline_index \
-i gzfastq \
-y fastq \
-E phred33 \
--bestrad \
-e sbfI \
-q \
--filter_illumina \
-c \
-t 130 \
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-r \
--barcode_dist_1 1 \
--barcode_dist_2 1 \

#################### PLATE 05: LIB INDEX GCCAAT ########################################################################

### Separates raw sequencing files into individual IDs based on matching barcodes

process_radtags \
-1 ${RAWDIR}/GCCAAT_S5_L003_R1_001.fastq.gz \
-2 ${RAWDIR}/GCCAAT_S5_L003_R2_001.fastq.gz \
-o $OUTDIR \
-b $BARCODES/rflib05_barcodes_withlib.txt \
--inline_index \
-i gzfastq \
-y fastq \
-E phred33 \
--bestrad \
-e sbfI \
-q \
--filter_illumina \
-c \
-t 130 \
--adapter_1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
--adapter_2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
-r \
--barcode_dist_1 1 \
--barcode_dist_2 1 \

## deactivate the conda environment
conda deactivate