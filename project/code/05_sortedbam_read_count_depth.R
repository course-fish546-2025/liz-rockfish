# install packages if not already installed
install.packages("ggplot2")
install.packages("dplyr")
install.packages("scales")

# load packages
library(ggplot2)
library(dplyr)
library(scales)

# load data
counts <- read.table("all_samples_read_counts.txt", header=FALSE, col.names=c("Sample", "ReadCount"))
mean_depths <- read.table("mean_depths.tsv", header=FALSE, col.names=c("Sample", "MeanDepth"))

# calculate mean and median of total read counts per individual
mean_rc <- mean(counts$ReadCount)
median_rc <- median(counts$ReadCount)

# total read counts plot
ggplot(counts, aes(x=ReadCount)) +
  geom_histogram(bins=50, fill="steelblue", color="black") +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  labs(title="Total Read Counts per Sample",
       x="Read Count", y="Number of Samples") +
  geom_vline(xintercept=mean_rc, color="red", linetype="dashed") +
  geom_vline(xintercept=median_rc, color="blue", linetype="dashed") +
  annotate("text", x=mean_rc, y=Inf, label=paste0("Mean: ", round(mean_rc)), vjust=1.5, hjust=-0.1, color="red") +
  annotate("text", x=median_rc, y=Inf, label=paste0("Median: ", round(median_rc)), vjust=3, hjust=-0.1, color="blue")

# calculate mean and median of read depth per individual
mean_depth <- mean(mean_depths$MeanDepth)
median_depth <- median(mean_depths$MeanDepth)

# mean depth plot
ggplot(mean_depths, aes(x=MeanDepth)) +
  geom_histogram(bins=50, fill="darkgreen", color="black") +
  theme_minimal() +
  labs(title="Mean Read Depth per Sample",
       x="Mean Read Depth", y="Number of Samples") +
  geom_vline(xintercept=mean_depth, color="red", linetype="dashed") +
  annotate("text", x=mean_depth, y=Inf, label=paste0("Mean: ", round(mean_depth, 2)), vjust=1.5, hjust=-0.1, color="red") +
  annotate("text", x=median_depth, y=Inf, label=paste0("Median: ", round(median_depth)), vjust=3, hjust=-0.1, color="blue")

# filtering read counts to get rid of the big outlier boys
filtered_readcounts <- counts %>%
  filter(ReadCount < 2e7)

mean_rc_filtered <- mean(filtered_readcounts$ReadCount)
median_rc_filtered <- median(filtered_readcounts$ReadCount)

# plotting this:
ggplot(filtered_readcounts, aes(x=ReadCount)) +
  geom_histogram(bins=50, fill="steelblue", color="black") +
  theme_minimal() +
  scale_x_continuous(labels = scales::comma) +
  labs(title="Total Read Counts per Sample (inds >20M reads removed)",
       x="Read Count", y="Number of Samples") +
  geom_vline(xintercept=mean_rc_filtered, color="red", linetype="dashed") +
  geom_vline(xintercept=median_rc_filtered, color="blue", linetype="dashed") +
  annotate("text", x=mean_rc_filtered, y=Inf, label=paste0("Mean: ", round(mean_rc_filtered)), vjust=1.5, hjust=-0.1, color="red") +
  annotate("text", x=median_rc_filtered, y=Inf, label=paste0("Median: ", round(median_rc_filtered)), vjust=3, hjust=-0.1, color="blue")

####### Mean depth minus big boys ##########

filtered_meandepths <- mean_depths %>%
  filter(MeanDepth < 60)

mean_depth_filtered <- mean(filtered_meandepths$MeanDepth)
median_depth_filtered <- median(filtered_meandepths$MeanDepth)

# mean depth plot minus big boys
ggplot(filtered_meandepths, aes(x=MeanDepth)) +
  geom_histogram(bins=50, fill="darkgreen", color="black") +
  theme_minimal() +
  labs(title="Mean Read Depth per Sample (inds depth >60 removed)",
       x="Mean Read Depth", y="Number of Samples") +
  geom_vline(xintercept=mean_depth_filtered, color="red", linetype="dashed") +
  annotate("text", x=mean_depth_filtered, y=Inf, label=paste0("Mean: ", round(mean_depth_filtered, 2)), vjust=1.5, hjust=-0.1, color="red") +
  annotate("text", x=median_depth_filtered, y=Inf, label=paste0("Median: ", round(median_depth_filtered)), vjust=3, hjust=-0.1, color="blue")

# check missing data
mean(depth$V3 == 0) * 100  # % missing bases