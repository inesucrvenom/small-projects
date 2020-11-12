![logo](../repo-python.png)

# analyse diff of two picture folders
November 2020

tech: **pandas, git diff (for files), exiftool**, jupyter notebook, gvim, json

Use case:
- there are around 10000 photos in two folders, 'oglasi' and 'arhiva'
- 'arhiva' is used to basically be backup, but was maintained manually, which included renaming files
- filenames have croatian characters, dots, commas - proper chaos

problem: figure out which pictures between the two folders are:
- missing in one of them
- just renamed
- modified in some way, and which
in order to have a single source of truth.

First, [get the list of the pictures](analyse_git_diff/git_diff_analyser.ipynb) which are potentially problematic, based on git diff result.

Then, [deepen the analysis](analyse_git_diff/dig_with_json.ipynb) combining the data with json exif data.


![logo](../repo-python.png)
