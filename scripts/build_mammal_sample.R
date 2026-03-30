library(U.PhyloMaker)
library(ape)

if (!dir.exists("output")) {
  dir.create("output", recursive = TRUE)
}

sp.list <- read.csv("data/species_lists/mammal_sample_species_list.csv")
megatree <- read.tree("data/megatrees/mammal_megatree.tre")
gen.list <- read.csv("data/genus_lists/mammal_genus_list.csv")

result <- phylo.maker(
  sp.list,
  megatree,
  gen.list,
  nodes.type = 1,
  scenario = 3
)

write.tree(result$phylo, "output/output_tree.tre")
write.csv(result$sp.list, "output/output_splist.csv")
