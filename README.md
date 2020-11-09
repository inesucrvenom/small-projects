![logo](repo-mix.png)

# small-projects
Various short projects that didn't get own home.

## analyse bank statements
November 2020

tech: pandas, jupyter notebook, json
new tech: camelot

Use case:
- my bank, Commerzbank.de, doesn't allow me to query data older than 1 year, with limited abilities
- it does store all my bank statements, in pdf
- I wanted to explore whole data and locate some specific costs (e.g. for tax return purposes)

Working horse here is camelot, and figuring out how it works exactly, but after that, I'm able to parse those transactions to satisfactory degree.
Current data is string only.


## analyse diff of two picture folders
November 2020

tech: jupyter notebook, gvim, json
new tech: pandas, git diff (for files), exiftool

Use case:
- there are around 10000 photos in two folders, 'oglasi' and 'arhiva'
- 'arhiva' is used to basically be backup, but was maintained manually, which included renaming files
- filenames have croatian characters, dots, commas - proper chaos

problem: figure out which pictures between the two folders are:
- missing in one of them
- just renamed
- modified in some way, and which
in order to have a single source of truth.

First, get the pictures which are potentially problematic, based on git diff result with **[this jupyter notebook](analyse_git_diff/git_diff_analyser.ipynb)**

Then, deepen the analysis combining the data with json exif data **[using the second jupyter notebook](analyse_git_diff/dig_with_json.ipynb)**


## logo for my sites
July 2020

new tech: inkscape

**[logo](logo)**

## Licence
All works here are published under [MIT licence](LICENCE)

![logo](repo-mix.png)
