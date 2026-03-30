# Local set-up

**TODO:** This set-up has only been tested on an M1 Mac.

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
