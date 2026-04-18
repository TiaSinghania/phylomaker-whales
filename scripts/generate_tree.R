#-------------------------------------------------------------------------------
# Script Name: generate_tree.R
# Author: Karen Wu, Samanvita Singhania
#
# Input:
#   First argument: megatree category 
#   Second argument: species list to generate tree for
#   Precondition: megatree category must have corresponding genus list and megatree
#                 in the `genus_lists/` and `megatrees/` directories
#   Precondition: species list must be located in the `species_lists` directory
#
# Output:
#   In `output` directory:
#   - `.csv` and `.tre` file with the tree's data
#   - `.png` file with a visualization of the tree
#
# Example usage:
#   Running `Rscript scripts/generate_tree.R mammal mammal_sample_species` will
#   result in `mammal_sample_species_splist.csv`, `mammal_sample_species_tree.tre`,
#   and `mammal_sample_species_plot.png` being generated in the `output` directory.
#-------------------------------------------------------------------------------

library(U.PhyloMaker)
library(ape)
library(ggtree)
library(ggplot2)
library(phytools)

# ------ Directory paths ------

megatree_dir <- "data/megatrees"
genus_dir <- "data/genus_lists"
species_dir <- "data/species_lists"
output_dir <- "output"

if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

# ------ Argument parsing ------

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 2) {
  stop("Please input the correct arguments (see file header)")
}

megatree_category <- args[1] # R vectors are 1-indexed :p
requested_species <- args[2]

megatree_file <- file.path(megatree_dir, paste0(megatree_category, "_megatree.tre"))
if (!file.exists(megatree_file)) stop("Megatree file not found: ", megatree_file)

genus_file <- file.path(genus_dir, paste0(megatree_category, "_genus_list.csv"))
if (!file.exists(genus_file)) stop("Genus list not found: ", genus_file)

species_input <- file.path(species_dir, paste0(requested_species, ".csv"))
if (!file.exists(species_input)) stop("Requested species list not found: ", requested_species)

tree_output <- file.path(output_dir, paste0(requested_species, "_tree.tre"))
splist_output <- file.path(output_dir, paste0(requested_species, "_splist.csv"))
visual_output <- file.path(output_dir, paste0(requested_species, "_plot.png"))

# ------ Run U.Phylomaker ------

megatree <- read.tree(megatree_file)
gen.list <- read.csv(genus_file)
sp.list <- read.csv(species_input)

result <- phylo.maker(
  sp.list,
  megatree,
  gen.list,
  nodes.type = 1,
  scenario = 3
)

write.tree(result$phylo, tree_output)
write.csv(result$sp.list, splist_output)

# ------ Generate visualization ------

phylo_tree <- read.tree(tree_output)

num_tips <- length(phylo_tree$tip.label)
max_height <- max(nodeHeights(phylo_tree))
x_extra <- max_height * 0.45

p <- ggtree(phylo_tree, size = 0.8, color = "grey30") + 
  geom_tiplab(
    size = 5, 
    align = TRUE, 
    linesize = 0.3, 
    linetype = "dotted",
    offset = 0.5,
    fontface = "italic"
  ) + 
  theme_tree2() +
  labs(title = paste("Phylogenetic Tree:", requested_species)) +
  xlim(0, max_height + x_extra) +
  theme(
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    axis.text.x = element_text(size = 12),
    plot.margin = margin(20, 120, 20, 20)
  )

plot_height <- max(8, num_tips * 0.35)

ggsave(visual_output, plot = p, width = 14, height = plot_height, dpi = 300)
cat("Plot saved to:", visual_output, "\n")
