![logo](repo-mix.png)

# small-projects
Various short projects that didn't get own home.

## logo for my sites
July 2020

tech: inkscape

[logo](logo)

## git diff analyser

November 2020

tech: pandas, jupyter notebook, gvim, git diff, exiftool, json

Use case:
- there are around 10000 photos in two folders, 'oglasi' and 'arhiva'
- 'arhiva' is used to basically be backup, but was maintained manually, which includes renaming files
- filenames have croatian characters, dots, commas - proper chaos

problem: figure out which pictures between the two folders are:
- missing in one of them
- just renamed
- modified in some way, and which
in order to have a single source of truth.

First, get the pictures which are potentially problematic, based on git diff result with [this notebook](analyse_git_diff/git_diff_analyser.ipynb)

Then, deepen the analysis combining the data with json exif data [using the second notebook](analyse_git_diff/dig_with_json.ipynb)

## Licence
All works here are published under [MIT licence](LICENCE)

![logo](repo-mix.png)
