---
layout: default
title:  Tutorial
nav_order: 3

---

# SEAS Tutorial
{: .no_toc }

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

---

## Data Importation.

SEAS require two data inputs from the user:
1.	Meta-Clinical data of Patients.
2.	Embedding of Patients/Samples

First input is the meta-clinical data of patients with n columns. Patient Identifier should be placed in first column. Values of first column should be identical in both the input files. Embedding of Patients can be uploaded in a csv format with 3 column data set. First column is the Patient Identifier, consecutive columns are X and Y coordinates of embedding. User can also choose select the option to calculate embedding directly through SEAS by selecting either tSNE or UMAP algorithm for the processed meta-clinical data set.
Accepted File Format: “.csv”

### Import Mode 1:

![Import Mode 1](https://aimed-uab.github.io/SEAS/docs/images/demo/ImportMode1.png)

### Import Mode 2:

![Import Mode 2](https://aimed-uab.github.io/SEAS/docs/images/demo/ImportMode2.png)

### For demo of SEAS:

![Import Mode 3 demo](https://aimed-uab.github.io/SEAS/docs/images/demo/ImportMode3_demo.png)

---

## Data Exploration

Upon uploading of dataset, SEAS allows user to visualize the clinotypic (patient features) relations through grouped bar plots and scatter plots.
SEAS automatically identifies the data type of each clinotype in dataset and places them in respective suitable plots. 
Linear Model Prediction is also added inside the scatter plot to visualize correlation between two clinotypes.

![Data Exploration](https://aimed-uab.github.io/SEAS/docs/images/demo/DataExplore1.png)

![Data Exploration](https://aimed-uab.github.io/SEAS/docs/images/demo/DataExplore2.png)

---

##	Cohort Selection

SEAS consist of three different methods for cohort selection from the embedding plot. Different methods provides user more flexibility in picking a cohort from a neighborhood or distantly located places depending on the hypothesis of experiment.

###	Neighborhood Selection Method.
The method allows user to select a patient of interest from the dropdown and then select a neighborhood (closely located) using a dynamic radius input. This method is useful ___”.

![Cohort Selection Mode 1](https://aimed-uab.github.io/SEAS/docs/images/demo/SelectionMode1.png)


###	Lasso + Box Selection Method. 
The method allows user to either free hand or box select multiple clusters of patients/samples from the embedding plot. 

![Cohort Selection Mode 2](https://aimed-uab.github.io/SEAS/docs/images/demo/SelectionMode2.png)

###	Custom Selection Method.
The method allows user to input or provide custom list of Patient Identifiers to select in the embedding plot. This method is useful when the user selects a cohort with prior knowledge either from clinical or genomic profiles of patients. 

![Cohort Selection Mode 3](https://aimed-uab.github.io/SEAS/docs/images/demo/SelectionMode3.png)

---

##	Enrichment Analysis

After successfully selecting a cohort, the user can now statistically analyze enrichment in cohort clinotypes comparing with population clinotypes. 

SEAS allows user to select a clinotype(s) of interest to test or simply select first option “All” to test whole dataset. 

User can also set the P-value threshold for the test or leave on default to 0.05.

A table with detailed information of results is shown to the right. Calculated values are p-value and adjusted p-value using FDR cutoff of 0.05.

![SEAS Analysis](https://aimed-uab.github.io/SEAS/docs/images/demo/Analysis.png)

---

##	Result 

Clinotypes which passed through the p-value threshold are shown here to further visualize the cohort and background relation using pie chart and boxplot. 
Each row in this table is clickable and simultaneously updates the visualization plots of selected/clicked clinotype.

![SEAS Result ](https://aimed-uab.github.io/SEAS/docs/images/demo/Results.png)
