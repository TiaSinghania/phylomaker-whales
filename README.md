# Local set-up

Before beginning, make sure you have R installed from [https://cran.r-project.org](https://cran.r-project.org). We are using the `renv` package to manage package dependencies.

To set up the project locally, run the following commands:
```
git clone https://github.com/TiaSinghania/phylomaker-whales.git
cd phylomaker-whales
Rscript -e 'renv::restore()'
```

If `renv` ever reports `project out-of-sync`, run:
```
renv::status()
renv::restore()
```

# Generating trees

To generate a tree for a given megatree and sample species list, run the following command:
```
Rscript scripts/generate_tree.R <megatree_category> <species_list_name>
```

See the file header of `scripts/generate_tree.R` for more information on the expected input.

# Potential bugs

The set-up process outlined above has been tested on an M1 Mac and a Windows machine, but not
on a Linux machine.

# Data sources

The data files in `data/genus_lists` and `data/megatrees` were obtained from [2].

# References

[1] Yi Jin and Hong Qian. U.phylomaker: An R Package That Can Generate Large Phylogenetic Trees
for Plants and Animals. _Plant Diversity_, 45(3):347–352, 2023.

[2] N.S. Upham, J.A. Esselstyn, and W.˜Jetz. Inferring the Mammal tree: Species-level Sets of
Phylogenies for Questions in Ecology, Evolution, and Conservation. _PLoS biology_, 17, 2019.
