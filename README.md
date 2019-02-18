# Red lists of Flanders, Belgium

The Red List Flanders Unvalidated and the Red List Flanders validated scripts are used to map the raw validated and raw unvalidated data to Darwin Core. The processed data than was than matched with the GBIF taxonomic backbpone to compare and retract species information.

In darwin core the data for both datasets is organized in a taxon + distribution + description scheme

The processed data is available on the (INBO-IPT)[https://ipt.inbo.be/resource?r=rl-flanders-validated-checklist]


## Rationale


This repository contains the functionality to standardize the data of Flanders validated and unvalidated checklists to a [Darwin Core checklist](https://www.gbif.org/dataset-classes) that can be harvested by [GBIF](httunp://www.gbif.org).

## Workflow

[source data](data/raw) → Darwin Core [mapping script](src/dwc_mapping.Rmd) → generated [Darwin Core files](data/processed)

## Published dataset


* [Dataset on the IPT](https://ipt.inbo.be/resource?r=rl-flanders-validated-checklist)
* [Dataset on GBIF](<!-- Add the DOI of the dataset on GBIF here -->)

## Repo structure


The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── checklist-recipe.Rproj : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── data
│   ├── raw                : Source data, input for mapping script
│   |   ├── valildated
    |   ├── unvalidated
    ├── interim            : Source data matched with GBIF taxonomic backbone
    |   ├── valildated
    |   ├── unvalidated
    └── p|rocessed         : Darwin Core output of mapping script GENERATED
        ├── valildated
        ├── unvalidated
│
├── docs                   : Repository website GENERATED
│
└── src
    ├── dwc_mapping.Rmd    : Darwin Core mapping script, core functionality of this repository
    ├── _site.yml          : Settings to build website in docs/
    └── index.Rmd          : Template for website homepage
```

## Installation


1. Clone this repository to your computer
2. Open the RStudio project file
3. Open the `dwc_mapping.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio
4. Install any required packages
5. Click `Run > Run All` to generate the processed data
6. Alternatively, click `Build > Build website` to generate the processed data and build the website in `docs/` (advanced)

## Contributors


[List of contributors](https://github.com/inbo/rl-flanders-checklist/graphs/contributors)

## License


[MIT License](LICENSE) for the code and documentation in this repository. The included data is released under another license.

