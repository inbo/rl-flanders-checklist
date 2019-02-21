# Red lists of Flanders, Belgium

## Rationale

This repository contains the functionality to standardize two checklists - the _Validated red lists of Flanders, Belgium_  and the _Non-validated red lists of Flanders, Belgium_ - to [Darwin Core checklists](https://www.gbif.org/dataset-classes) that can be harvested by [GBIF](http://www.gbif.org). The repository also contains some miscellaneous scripts.

## Workflow

The source data is an Access database managed by [Dirk Maes](https://orcid.org/0000-0002-7947-3788) containing **all published red lists for Flanders** ([see included red lists](https://inbo.github.io/rl-flanders-checklist/index.html)). A taxon can appear on multiple red lists. The data are split into two datasets, depending on the type of red list:

* **Validated red lists**: Contains information from red lists that were developed using the IUCN protocol. The database contains species properties for these (`biome`, `biotope`, `cuddliness`, `lifespan`, `mobility`, `nutrient level`, `spine`) which has been included in the Description extension.

    [source data](https://github.com/inbo/rl-flanders-checklist/blob/master/data/raw) (exported from Access) → Darwin Core [mapping script](https://inbo.github.io/rl-flanders-checklist/dwc_mapping_validated.html) → generated [Darwin Core files](https://github.com/inbo/rl-flanders-checklist/blob/master/data/processed/validated)

* **Non-validated red lists**: Contains information from red lists that were _not_ developed using the IUCN protocol.

    [source data](https://github.com/inbo/rl-flanders-checklist/blob/master/data/raw) (exported from Access, same file) → Darwin Core [mapping script](https://inbo.github.io/rl-flanders-checklist/dwc_mapping_nonvalidated.html) → generated [Darwin Core files](https://github.com/inbo/rl-flanders-checklist/blob/master/data/processed/nonvalidated)

## Published dataset

* [Validated red lists on the IPT](https://ipt.inbo.be/resource?r=rl-flanders-validated-checklist)
* [Validated red lists on GBIF]()

---

* [Non-validated red list on the IPT](https://ipt.inbo.be/resource?r=rl-flanders-unvalidated-checklist)
* [Non-validated red lists on GBIF]()

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── rl-flanders-checklist.Rproj : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── data
│   ├── raw                : Source data, input for mapping scripts 1 and 2
│   └── processed
│       ├── validated      : Darwin Core output of mapping script 1 GENERATED
│       └── nonvalidated   : Darwin Core output of mapping script 2 GENERATED
│
├── docs                   : Repository website GENERATED
│
└── src
    ├── dwc_mapping_validated.Rmd : Darwin Core mapping script 1 (for validated red lists)
    ├── dwc_mapping_nonvalidated.Rmd : Darwin Core mapping script 2 (for non-validated red lists)
    ├── _site.yml          : Settings to build website in docs/
    └── index.Rmd          : Template for website homepage
```

## Installation

1. Clone this repository to your computer
2. Open the RStudio project file
3. Open the `dwc_mapping_validated.Rmd` or `dwc_mapping_nonvalidated.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio
4. Install any required packages
5. Click `Run > Run All` to generate the processed data
6. Alternatively, click `Build > Build website` to generate the processed data and build the website in `docs/`

## Contributors

[List of contributors](https://inbo/rl-flanders-checklist/ad-hoc-checklist/contributors)

## License

[MIT License](https://github.com/inbo/rl-flanders-checklist/blob/master/LICENSE)
