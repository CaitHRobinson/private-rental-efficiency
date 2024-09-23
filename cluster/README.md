# cluster-analysis

*Language:* R

📌 **Section summary:** K-means clustering is used to derive our final classification. In this section we show how k-means clustering is carried out and the optimal number of clusters selected.

*K-means clustering:* K-means iteratively relocates data points between a predefined set of k clusters. Each observation belongs to the cluster with the nearest mean. Clusters have a high degree of similarity within, and low degree of similarity between them. We use a MacQueen variation that recalculates cluster centroids each time it iterates over a datapoint, until they converge. 

*Preparing the data:* Prior to cluster analysis, variables are recalculated as percentages and standardised using z-scores. We select 11 EPC variables to be included in the cluster analysis.

*Choosing the optimal cluster number:* Several diagnostics evaluate the final number of clusters including a between-cluster and within-cluster sum of squares statistic. We choose a nine-cluster solution, balancing detail with usability. Clusters names describe the density, geography, and intensity of inefficiency.

📊 **Final clusters for OA in England and Wales**: We include a [dataset of the final classification](https://github.com/CaitHRobinson/private-rental-efficiency/blob/main/cluster/PRS_EPC_OA_clusters_9.zip) for OA nationally for a nine cluster solution.

<img src="https://github.com/user-attachments/assets/f7972654-0857-4589-bea0-b648a0d37689">





