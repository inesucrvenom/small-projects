# analyse bank statements

November 2020

tech: **pandas**, **camelot**, jupyter notebook, json

Use case:
- my bank, Commerzbank.de, doesn't allow me to query data older than 1 year, with limited abilities
- it does store all my bank statements, in pdf
- I wanted to explore whole data and locate some specific costs (e.g. for tax return purposes)

Working horse here is camelot, and figuring out how it works exactly, but after that, I'm able to parse those transactions to satisfactory degree.
Current data is string only.

Usage:
- [create .json reports](create_json_yearly_report.ipynb) of whole year
- import that file for [analysis](analyse_yearly_json_report.ipynb)
