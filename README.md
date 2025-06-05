# liz-rockfish

Welcome to my FISH 546 repo!

Aside from assignments and question sets, my work here also consists of a project invovling my MS research, which is on three closely related species of rockfish (*Sebastes spp.*) in Puget Sound, WA.
With raw RAD-seq sequence data, I will examine population structure between these species and between several regions of Puget Sound and the coast. I am processing my data during this class in a commonly used bioinformatics pipeline for this type of data.

For this portion of my project, this consists of:
  1. Checking sequence quality with `FastQC` (and visualizing those results in an interactive way with `MultiQC`)
  2. Running my raw data through `process_radtags` in *STACKS2* to demultiplex my sequences based on their barcodes, truncate reads to 130bp, and filter based on quality
  3. Aligning to a genome with `bowtie2` - in this case, the honeycomb rockfish (closest relative to my three species)
  4. Convert .sam files (output from `bowtie2`) to .bam and .sorted.bam files
  5. Check total read counts per individual and mean read depth per individual using `samtools` and plot histograms using `ggplot2` in R
  7. Check read counts and depth of reads on 5 negative controls (negative controls from extraction plates - 1 per 96-well plate, nothing added except protocol reagents)

Week 06 project updates: https://rpubs.com/lizboggs/week06projectupdates-fish546

**Compendium link:** https://rpubs.com/lizboggs/rockfish-compendium-546 

DOI: [![DOI](https://zenodo.org/badge/958870260.svg)](https://doi.org/10.5281/zenodo.15588397)
