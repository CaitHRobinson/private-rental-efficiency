# cleaning-epc-data

*Language:* R

**Section summary:** We analyse new property-scale Energy Performance Certificates (EPC). In this section we explain [how to clean and prepare the EPC variables](https://github.com/CaitHRobinson/private-rental-efficiency/blob/main/clean/clean-code.r) of interest, for an example region of the North East of England. 

<img src="https://github.com/user-attachments/assets/323e2039-d2e7-4620-81af-7505d7c51d28" width=50% height=50%>


*Downloading EPC data*: EPC data are appended to Unique Property Reference Numbers - unique identifiers for every address. We download the EPC data for properties in Local Authority Districts from [Open Data Communities](https://epc.opendatacommunities.org/), which provides property-scale EPC data that can be joined to the [UPRN shapefile](https://osdatahub.os.uk/downloads/open/OpenUPRN).

*Cleaning EPC data:* Our code filters only EPC issued between September 2012 and September 2022 (ODC, 2022). We select only one EPC for each address and the most recent certificate. We replace NA values with 0.

*EPC variables:* EPC include aggregate scores for efficiency and consumption, and physical attributes and efficiency characteristics. Efficiency ratings are estimated between A-G, with A being most efficient (Table 1). Our variables relate to the most intensive energy services – space and water heating. Whilst most variables negatively impact efficiency (e.g., older properties often have inefficient solid walls), some are positive and negative.

*Aggregating EPC data:* EPC property data is aggregated to [Output Areas (OA)](https://www.ons.gov.uk/methodology/geography/ukgeographies/censusgeographies/census2021geographies) to overcome gaps in the dataset. OA contain between 40 and 250 households - as demographically close as possible to street-level. 

**Final EPC variables for OA in England and Wales:** We repeat the process for all regions, creating a [final dataset](https://github.com/CaitHRobinson/private-rental-efficiency/blob/main/clean/PRS_EPC_OA_counts_over5.zip) of variables for all OA  in England and Wales. Here, OA with 5 or less private rental properties with an EPC are removed. The datasets provides the input into our [cluster](https://github.com/CaitHRobinson/private-rental-efficiency/edit/main/cluster) analysis.

