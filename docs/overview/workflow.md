---
layout: default
title: Session Workflow
parent: SEAS Overview
nav_order: 2

---
## SEAS session workflow


![Figure 1](https://aimed-uab.github.io/SEAS/docs/overview/figure1.jpg)

As showed in Figure 1, a SEAS session [https://aimed-lab.shinyapps.io/SEAS/](https://aimed-lab.shinyapps.io/SEAS/){:target="_blank"} includes three steps:
- Uploading data: the user upload the clinical metadata for each sample (required) and/or the embedding for these samples (optional)
The purpose of embedding is to visualize the similarity among the samples. Each sample is represented by a 2D point. The closer the two points are, the more similar the two samples are.
- Selecting cohort: the user can manually select an interested subcohort or use the embedding to select a subcohort where the samples are similar to each other.
- Analyze: the result shows which clinical attributes are enriched (dominant) in the selected subcohort. For each attribute, its the p-value tells, statistically, how likely the attribute are enriched. By default, if the p-value is less than 0.05, the attribute is considered significantly enriched.

The functional workflow is as follow:

![SEAS Workflow](https://aimed-uab.github.io/SEAS/docs/overview/SEAS_workflow.png)
