#!/bin/bash
#SBATCH --job-name=clone_filter_rf_freshrun060625
#SBATCH --account=coenv
#SBATCH --partition=compute
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=16:00:00
## Memory per node
#SBATCH --mem=150G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lizboggs@uw.edu

### This script runs STACKS clone_filter, which removes PCR duplicate reads (known as clones) ###

##### ENVIRONMENT SETUP ##################################
## Specify the directories containing data
DATADIR=/mmfs1/gscratch/scrubbed/lizboggs/demux_by_lib_freshrun060325
OUTDIR=/mmfs1/gscratch/scrubbed/lizboggs/clone_filter_freshrun060625
MYCONDA=/gscratch/merlab/software/miniconda3/etc/profile.d/conda.sh
MYENV=stacks_env

## start with clean slate
module purge

## This is the filepath to our conda installation on Klone. Source command will allow us to execute commands from a file in the current shell
source $MYCONDA

## activate the conda environment
conda activate $MYENV

############ Run clone_filter #############################
cd $DATADIR

IND_ID=$(cat /gscratch/merlab/lizboggs/barcodes/clonefilter_barcodes.txt | cut -f3)

for i in ${IND_ID};
do
echo i
clone_filter \
-1 $DATADIR/${i}.1.fq \
-2 $DATADIR/${i}.2.fq \
-o $OUTDIR \
&>> $OUTDIR/output.txt

done

mv *.1.1.fq ../clone_filter_freshrun060625
mv *.2.2.fq ../clone_filter_freshrun060625

for i in ${IND_ID};
do

 cat /gscratch/scrubbed/lizboggs/clone_filter_freshrun060625/${i}.1.1.fq > /gscratch/scrubbed/lizboggs/clone_filter_freshrun060625/${i}.1.fq
 cat /gscratch/scrubbed/lizboggs/clone_filter_freshrun060625/${i}.2.2.fq > /gscratch/scrubbed/lizboggs/clone_filter_freshrun060625/${i}.2.fq

done

## deactivate the conda environment
conda deactivate