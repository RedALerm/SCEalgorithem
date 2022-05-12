# SCEalgorithem
For 《Solving Soft Clustering Ensemble via k-Sparse Discrete Wasserstein Barycenter》

## Requirements

- Matlab 
- Windows


########################  Experiments  #####################################

## Usage

You can run main_USPS.m/ main_IRIS.m/ main_CIFAR directly ( Because these datasets have different ground-truth and the number of clusterings).

Our alg:
- AMr.m: our main algorithm ( r means the rate of sampling ).
- DWB2.m: use k-sparse DWB2 algorithm  in (Ding et.al.,2016) to compute the final ensemble clustering.

Other comparison alg:
- BGP.m: the ensemble algorithm by bipartite graph partitioning.
- FUR.m: the top-down clustering aggregation method Furthest.

## Notes

- The code for BGP can be found at https://github.com/nejci/PRAr/blob/5eae71e248b35dfc025fc3825410fc2959673f67/Pepelka/methods/HBGF/HBGF.m
- Due to the limitation of the size of the files, we can't upload all the experimental datasets.
- The running time of FUR.m may be a little long.
- If you want to run the code on Linux or Mac OS, please recompile to generate all MEX files.




########################  Applications  #####################################

## Usage

You can run main_rate.m/ main_cycle.m in file "compare" directly to compare the result of accelerating algorithms and clustering in the original space.
Run main.m in file "noise" to study the robustness of our methods under the attack of noise.

Our alg:
- ACCELERATE.m: using JL transform or PCA to accelerate the clustering of datasets in high-dimension. 
- DWB2.m: use k-sparse DWB2 algorithm  in (Ding et.al.,2016) to compute the final ensemble clustering.

The comparison:
- ORIGINAL.m: the clustering result in the original space.

## Notes

- In noisy situation, we set the number of individual clusterings five and the rate of dimensional reduction 5%.
