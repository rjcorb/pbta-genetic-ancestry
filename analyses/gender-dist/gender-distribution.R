# R Corbett 2024
#
# Plot gender distribution across tumor histology patient groups

# load libraries and set directories
library(data.table)
library(tidyverse)
library(ComplexHeatmap)
library(RColorBrewer)
library(circlize)
library(colorblindr)

root_dir <- rprojroot::find_root(rprojroot::has_dir(".git"))

# Set file paths
data_dir <- file.path(root_dir, "data")
analysis_dir <- file.path(root_dir, "analyses", "gender-dist")
results_dir <- file.path(analysis_dir, "results")
input_dir <- file.path(analysis_dir, "input")
plots_dir <- file.path(analysis_dir, "plots")

# call plot theme 
source(file.path(root_dir, "figures", "theme.R"))
source(file.path(root_dir, "analyses", 
                 "add-histologies", "util", "heatmap_function.R"))

# set file paths
ancestry_file <- file.path(root_dir, "analyses", 
                           "add-histologies", "results",
                           "merged_ancestry_histology_data.tsv")

# wrangle data
ancestry <- read_tsv(ancestry_file) %>%
  dplyr::filter(reported_gender %in% c("Female", "Male"))


# Open pdf file
pdf(file.path(plots_dir, "plot_group_gender_ct_enr_heatmap.pdf"),
    height = 8, width = 6)

# Plot plot_group - ancestry enrichment
group_ht <- plot_enr(ancestry, 
                     var1 = "plot_group", 
                     var2 = "reported_gender",
                     var1_names = sort(unique(ancestry$plot_group)),
                     var2_names = sort(unique(ancestry$reported_gender)),
                     padjust = TRUE)

# draw plot
draw(group_ht)

# shut off device 
invisible(dev.off())

# print session info
sessionInfo()
