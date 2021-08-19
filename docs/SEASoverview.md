---
layout: default
title: SEAS Overview
nav_order: 5

---
# SEAS Overview
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




## SEAS purpose

Statistical Enrichment Analysis of Samples (SEAS) is a tool to find which clinical (metadata) attributes are enriched within a sample subset. For example, SEAS answer the following questions:
* I have population data with brain cancer survival time; I select an interested patient subcohort, such as who received X treatment; does this subcohort have long survival time?
SEAS can be used to infer or annotate the unknown clinical (metadata) attribute of a sample. For example:
* I same a brain cancer patient whom I do not know the survival time; can I use SEAS to infer the survival time of the patient?
To do so, I can define a subcohort, which includes the most similar patients to the unknown survival-time patient. The question is converted to the one above, which can be answered by SEAS. Also, in SEAS, I can use embedding to view similar patients.



## SEAS session workflow

## Input and output format

## Navigating through SEAS

## Current technical limitation

* The current SEAS version is deployed in an online machine where the memory allocation is only 2GB. Therefore, we recommend that the input file size should be less than 100 MB. This input size usually has less than 10000 samples.
* The user may see the error, which says, ‘An error has occurred. Check your logs or contact the app author for clarification’. We have investigated these issues and found that the issues are not related to our implementation. Two reasons for these issues are:
* Long time without interaction. Usually, the SEAS online tool would return an error if the user does not interact with SEAS within 3-5 minutes
* System slow computation and response. That is, the user interacts and expects some visualization (i.e. embedding plot) while the system has not yet computed and processed.
To completely solve these issues, we may upgrade the SEAS server. This requires a monthly payment to shinyapps.io. Due to the financial processing time requirement, we have not yet completed the paperwork for the upgrade. Meanwhile, the user may try deploying SEAS code at shinyapps.io inside an in-house computer.

## How to contribute to SEAS

We welcome the user’s feedback and contributed dataset for future SEAS development. Please email SEAS developer the issues and sample dataset at:
jakechen@uab.edu (Jake Chen, supervisor)
thamnguy@uab.edu (Thanh Nguyen, the architect)
sbharti@uab.edu (Samuel Bharti, the programmer).
