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


---

## SEAS session workflow

<!-- To specify a page order, you can use the `nav_order` parameter in your pages' YAML front matter.

#### Example
{: .no_toc } -->

<!-- The parameter values determine the order of the top-level pages, and of child pages with the same parent. You can reuse the same parameter values (e.g., integers starting from 1) for the child pages of different parents.

The parameter values can be numbers (integers, floats) and/or strings. When you omit `nav_order` parameters, they default to the titles of the pages, which are ordered alphabetically. Pages with numerical `nav_order` parameters always come before those with strings or default `nav_order` parameters. If you want to make the page order independent of the page titles, you can set explicit `nav_order` parameters on all pages.

By default, all Capital letters come before all lowercase letters; you can add `nav_sort: case_insensitive` in the configuration file to ignore the case. Enclosing strings in quotation marks is optional.

> *Note for users of previous versions:* `nav_sort: case_insensitive` previously affected the ordering of numerical `nav_order` parameters: e.g., `10` came before `2`. Also, all pages with explicit `nav_order` parameters previously came before all pages with default parameters. Both were potentially confusing, and they have now been eliminated. 

--- -->

## Input and output format

<!-- For specific pages that you do not wish to include in the main navigation, e.g. a 404 page or a landing page, use the `nav_exclude: true` parameter in the YAML front matter for that page.

#### Example
{: .no_toc }

```yaml
---
layout: default
title: 404
nav_exclude: true
---
```

The `nav_exclude` parameter does not affect the [auto-generating list of child pages](#auto-generating-table-of-contents), which you can use to access pages excluded from the main navigation.

Pages with no `title` are automatically excluded from the navigation. 

--- -->

## Navigating through SEAS

<!-- Sometimes you will want to create a page with many children (a section). First, it is recommended that you keep pages that are related in a directory together... For example, in these docs, we keep all of the written documentation in the `./docs` directory and each of the sections in subdirectories like `./docs/ui-components` and `./docs/utilities`. This gives us an organization like:

```
+-- ..
|-- (Jekyll files)
|
|-- docs
|   |-- ui-components
|   |   |-- index.md  (parent page)
|   |   |-- buttons.md
|   |   |-- code.md
|   |   |-- labels.md
|   |   |-- tables.md
|   |   +-- typography.md
|   |
|   |-- utilities
|   |   |-- index.md      (parent page)
|   |   |-- color.md
|   |   |-- layout.md
|   |   |-- responsive-modifiers.md
|   |   +-- typography.md
|   |
|   |-- (other md files, pages with no children)
|   +-- ..
|
|-- (Jekyll files)
+-- ..
```

On the parent pages, add this YAML front matter parameter:
-  `has_children: true` (tells us that this is a parent page)

#### Example
{: .no_toc }

```yaml
---
layout: default
title: UI Components
nav_order: 2
has_children: true
---
```

Here we're setting up the UI Components landing page that is available at `/docs/ui-components`, which has children and is ordered second in the main nav.

### Child pages
{: .text-gamma }

On child pages, simply set the `parent:` YAML front matter to whatever the parent's page title is and set a nav order (this number is now scoped within the section).

#### Example
{: .no_toc }

```yaml
---
layout: default
title: Buttons
parent: UI Components
nav_order: 2
---
```

The Buttons page appears as a child of UI Components and appears second in the UI Components section.

### Auto-generating Table of Contents

By default, all pages with children will automatically append a Table of Contents which lists the child pages after the parent page's content. To disable this auto Table of Contents, set `has_toc: false` in the parent page's YAML front matter.

#### Example
{: .no_toc }

```yaml
---
layout: default
title: UI Components
nav_order: 2
has_children: true
has_toc: false
---
```

### Children with children
{: .text-gamma }

Child pages can also have children (grandchildren). This is achieved by using a similar pattern on the child and grandchild pages.

1. Add the `has_children` attribute to the child
1. Add the `parent` and `grand_parent` attribute to the grandchild

#### Example
{: .no_toc }

```yaml
---
layout: default
title: Buttons
parent: UI Components
nav_order: 2
has_children: true
---
```

```yaml
---
layout: default
title: Buttons Child Page
parent: Buttons
grand_parent: UI Components
nav_order: 1
---
```

This would create the following navigation structure:

```
+-- ..
|
|-- UI Components
|   |-- ..
|   |
|   |-- Buttons
|   |   |-- Button Child Page
|   |
|   |-- ..
|
+-- ..
```

--- -->

## Current technical limitation

* The current SEAS version is deployed in an online machine where the memory allocation is only 2GB. Therefore, we recommend that the input file size should be less than 100 MB. This input size usually has less than 10000 samples.
* The user may see the error, which says, ‘An error has occurred. Check your logs or contact the app author for clarification’. We have investigated these issues and found that the issues are not related to our implementation. Two reasons for these issues are:
* Long time without interaction. Usually, the SEAS online tool would return an error if the user does not interact with SEAS within 3-5 minutes
* System slow computation and response. That is, the user interacts and expects some visualization (i.e. embedding plot) while the system has not yet computed and processed.
To completely solve these issues, we may upgrade the SEAS server. This requires a monthly payment to shinyapps.io. Due to the financial processing time requirement, we have not yet completed the paperwork for the upgrade. Meanwhile, the user may try deploying SEAS code at shinyapps.io inside an in-house computer.


<!-- To add auxiliary links to your site (in the upper right on all pages), add it to the `aux_links` [configuration option]({{ site.baseurl }}{% link docs/configuration.md %}#aux-links) in your site's `_config.yml` file.

#### Example
{: .no_toc }

```yaml
# Aux links for the upper right navigation
aux_links:
  "Just the Docs on GitHub":
    - "//github.com/pmarsceill/just-the-docs"
```

--- -->

## How to contribute to SEAS

We welcome the user’s feedback and contributed dataset for future SEAS development. Please email SEAS developer the issues and sample dataset at:
jakechen@uab.edu (Jake Chen, supervisor)
thamnguy@uab.edu (Thanh Nguyen, the architect)
sbharti@uab.edu (Samuel Bharti, the programmer).


<!-- To generate a Table of Contents on your docs pages, you can use the `{:toc}` method from Kramdown, immediately after an `<ol>` in Markdown. This will automatically generate an ordered list of anchor links to various sections of the page based on headings and heading levels. There may be occasions where you're using a heading and you don't want it to show up in the TOC, so to skip a particular heading use the `{: .no_toc }` CSS class. -->

<!-- #### Example
{: .no_toc }

```markdown
# Navigation Structure
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}
```

This example skips the page name heading (`#`) from the TOC, as well as the heading for the Table of Contents itself (`##`) because it is redundant, followed by the table of contents itself. To get an unordered list, replace  `1. TOC` above by `- TOC`.

### Collapsible Table of Contents

The Table of Contents can be made collapsible using the `<details>` and `<summary>` elements , as in the following example. The attribute `open` (expands the Table of Contents by default) and the styling with `{: .text-delta }` are optional.

```markdown
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>
```

The result is shown at [the top of this page](#navigation-structure) (`{:toc}` can be used only once on each page).
 -->