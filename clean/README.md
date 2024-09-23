# cleaning-epc-data

EPC data is compiled for 3.9 million private rental properties in England and Wales as part of this analysis (~78.8% of sector). EPC data is most complete for private rentals because a new certificate must be obtained every decade, unlike owner-occupied properties. The code in this folder show how to clean and prepare the EPC variables of interest for the example region of the North East of England.

**EPC data**: EPC data appended to Unique Property Reference Numbers - unique identifiers for every address - offer detailed insights into housing characteristics previously impossible to achieve using open-source data. We download the EPC data for properties in Local Authority Districts from Open Data Communities.

**Cleaning EPC data:** We use EPC issued between September 2012 and September 2022 (ODC, 2022). We select only one EPC for each address. We select only the most recent certificate. We replace NA values with 0.

**EPC vairables:** EPC include aggregate scores for efficiency and consumption, and physical attributes and efficiency characteristics. Efficiency ratings are estimated between A-G, with A being most efficient (Table 1). Our variables relate to the most intensive energy services – space and water heating. Whilst most variables negatively impact efficiency (e.g., older properties often have inefficient solid walls), some are positive and negative.

**Aggregating EPC data:** EPC property data is aggregated to Output Areas (OA) (n = 188,871) to overcome gaps in the dataset (ONS, 2022b.). OA contain between 40 and 250 households - as demographically close as possible to street-level. 

The code here shows how this process is carried out for the North East region of England. We aggregate the data for all regions in England and Wales. A final dataset of variables for all OA is available here.
