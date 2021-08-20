---
layout: default
title: Limitations
parent: Overview
nav_order: 5

---

## Current technical limitation

* The current SEAS version is deployed in an online machine where the memory allocation is only 2GB. Therefore, we recommend that the input file size should be less than 100 MB. This input size usually has less than 10000 samples.
* The user may see the error, which says, ‘An error has occurred. Check your logs or contact the app author for clarification’. We have investigated these issues and found that the issues are not related to our implementation. Two reasons for these issues are:
* Long time without interaction. Usually, the SEAS online tool would return an error if the user does not interact with SEAS within 3-5 minutes
* System slow computation and response. That is, the user interacts and expects some visualization (i.e. embedding plot) while the system has not yet computed and processed.
To completely solve these issues, we may upgrade the SEAS server. This requires a monthly payment to shinyapps.io. Due to the financial processing time requirement, we have not yet completed the paperwork for the upgrade. Meanwhile, the user may try deploying SEAS code at shinyapps.io inside an in-house computer.