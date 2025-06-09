#!/bin/bash
#SBATCH --job-name=bowtie2_rf_freshrun060625
#SBATCH --account=coenv
#SBATCH --partition=cpu-g2
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=3-04:00:00
## Memory per node
#SBATCH --mem=300G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lizboggs@uw.edu

### This script runs the alignment program bowtie2 on fq files generated from STACKS process_radtags and clone_filter ###

##### ENVIRONMENT SETUP ##########
DATADIR=/mmfs1/gscratch/scrubbed/lizboggs/clone_filter_freshrun060625 # input files that were previously demuxed
MYLANEID=621.3 # The sequencing id of the lane (you can set this to whatever value you want)
GENOMEDIR=/mmfs1/gscratch/merlab/lizboggs/genome # The directory containing the reference genome
GENOME_PREFIX=GCF_015220745.1_fSebUmb1.pri_genomic # prefix of .bt2 files made by bowtie2 (the name of the genome, without the suffixes)
SUFFIX1=.1.fq # Suffix to the fastq files -  The forward reads with paired-end data.
SUFFIX2=.2.fq # Suffix to the fastq files - The reverse reads with paired-end data.
OUTDIR=/mmfs1/gscratch/scrubbed/lizboggs/sam_freshrun060625 # where to store output files

##############################################################################

export PATH=/mmfs1/gscratch/merlab/software/miniconda3/bin:$PATH

## 1. Index the rockfish genome so bowtie2 can use it (can comment out if already indexed)
# bowtie2-build -f $GENOMEDIR'/'$GENOME_PREFIX'.fna' $GENOMEDIR'/'$GENOME_PREFIX

## 2.  Make directory for output files (commented out if already made prior to running this script)
mkdir $OUTDIR

## 3. Move into the directory containing the fastq files
cd $DATADIR

## 4. Run bowtie over all samples in the sample list
for MYFILE in $DATADIR'/'*$SUFFIX1
do
        echo $MYFILE
        MYBASE=`basename --suffix=$SUFFIX1 $MYFILE`
        echo ${MYBASE}
        bowtie2 -x $GENOMEDIR'/'$GENOME_PREFIX\
        --phred33 -q \
        -1 ${MYBASE}$SUFFIX1 \
        -2 ${MYBASE}$SUFFIX2 \
        -S ${MYBASE}.sam \
        --very-sensitive \
        --minins 0 --maxins 1500 --fr \
        --threads ${SLURM_JOB_CPUS_PER_NODE} \
        --rg-id ${MYBASE} --rg SM:${MYBASE} --rg LB:${MYBASE} --rg PU:${MYLANEID} --rg PL:ILLUMINA
done

# Move all of the sam files to the output directory
mv *'.sam' $OUTDIR