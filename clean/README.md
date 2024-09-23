# cleaning-epc-data

This folder shows [how to clean and prepare the EPC variables](https://github.com/CaitHRobinson/private-rental-efficiency/blob/main/clean/clean-code.r) of interest for the example region of the North East of England. We repeat this process for all regions in England and Wales, and a final dataset of variables for all OA nationally is available here.

<img src="https://github.com/user-attachments/assets/323e2039-d2e7-4620-81af-7505d7c51d28" width=50% height=50%>


**Downloading EPC data**: EPC data are appended to Unique Property Reference Numbers - unique identifiers for every address. We download the EPC data for properties in Local Authority Districts from [Open Data Communities](https://epc.opendatacommunities.org/), which provides property-scale EPC data that can be joined to the [UPRN shapefile](https://osdatahub.os.uk/downloads/open/OpenUPRN).

**Cleaning EPC data:** Our code filters only EPC issued between September 2012 and September 2022 (ODC, 2022). We select only one EPC for each address and the most recent certificate. We replace NA values with 0.

**EPC variables:** EPC include aggregate scores for efficiency and consumption, and physical attributes and efficiency characteristics. Efficiency ratings are estimated between A-G, with A being most efficient (Table 1). Our variables relate to the most intensive energy services – space and water heating. Whilst most variables negatively impact efficiency (e.g., older properties often have inefficient solid walls), some are positive and negative.

**Aggregating EPC data:** EPC property data is aggregated to Output Areas (OA) (n = 188,871) to overcome gaps in the dataset (ONS, 2022b.). OA contain between 40 and 250 households - as demographically close as possible to street-level. 
