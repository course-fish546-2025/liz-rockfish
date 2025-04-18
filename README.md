# liz-rockfish

Welcome to my FISH 546 repo!

Aside from assignments and question sets, my work here also consists of a project involing my MS research, which is on three closely related species of rockfish (*Sebastes spp.*) in Puget Sound, WA.
With raw RAD-seq sequence data, I will examine population structure between these species and between several regions of Puget Sound and the coast.
This involves:
  1. Checking sequence quality with FastQC (and visualizing those results in an interactive way with MultiQC)
  2. Running my raw data through `process_radtags` in *STACKS* to demultiplex my sequences based on their barcodes and filtering based on quality (Phred score >33)
  3. Aligning to a genome with bowtie2 - in this case, the honeycomb rockfish (closest relative to my three species)
  4. Use `gstacks` and `populations` modules in *STACKS* to perform SNP calling and basic statistics
  5. Create PCA plots using *adegenet,* an R package, to examine inter- and intraspecific population structure patterns & clustering

More information to come!
