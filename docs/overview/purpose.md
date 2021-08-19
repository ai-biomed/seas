---
layout: default
title: Purpose
parent: SEAS Overview
nav_order: 1

---

## SEAS purpose

Statistical Enrichment Analysis of Samples (SEAS) is a tool to find which clinical (metadata) attributes are enriched within a sample subset. For example, SEAS answer the following questions:
* I have population data with brain cancer survival time; I select an interested patient subcohort, such as who received X treatment; does this subcohort have long survival time?
SEAS can be used to infer or annotate the unknown clinical (metadata) attribute of a sample. For example:
* I same a brain cancer patient whom I do not know the survival time; can I use SEAS to infer the survival time of the patient?
To do so, I can define a subcohort, which includes the most similar patients to the unknown survival-time patient. The question is converted to the one above, which can be answered by SEAS. Also, in SEAS, I can use embedding to view similar patients.
