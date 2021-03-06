---
outputs:
- Reveal
title: GET last tips
hidden: true
layout: list
weight: 11
output: hugodown::md_document
countdown: true
rmd_hash: 63d53009751780be

---

<div class="highlight">

</div>

## Beyond inline expectations

When you want to test

-   large/complicated output,

-   binary files like images,

-   error messages...

Think about **snapshot testing**!

From testthat third edition.

{{% note %}} We will use another way to write expectation, where we make a "snapshot" of the output, code, messages etc. We will use snapshot testing for an error message, but that will help us get to know the concept. To use snapshot testing one needs to use testthat third edition. If you are getting started with testing, you'll have little to convert. If not, refer to the testthat third edition vignette or webinar. {{% /note %}}

------------------------------------------------------------------------

## Another testthat trick

Custom skippers to run some tests only where you want.

Some built-in skippers: operating system, CRAN, etc.

{{% note %}} Another useful thing we will see is how to define a custom skipper. We will not see how to write custom expectation, but that is possible too. {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

{{% note %}} Time for a demo. {{% /note %}}

------------------------------------------------------------------------

## What we just saw

-   Snapshot testing

-   Custom skippers

{{% note %}} Further information can be found in testthat docs... and in tests of other packages. {{% /note %}}

------------------------------------------------------------------------

## What about real requests?

Fixtures are great but what if the API output changed & we didn't notice? :scream:

Let's schedule runs of continuous integration, where we turn off vcr.

{{% note %}} One last important and potentially tricky thing is still testing how your package works with real API requests once in a while. It would help you catch changes in the API for instance. {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

------------------------------------------------------------------------

## How to get better at writing CI workflows?

Get inspired by others!

{{< tweet 1205183124868681728 >}}

{{% note %}} We added a workflow that runs once a week with real requests. We tweaked an existing workflow, and stored our secret token as repo secret. Now what if we want to make things fancier? We can read the GitHub Actions docs, but also examples in other repos. {{% /note %}}

------------------------------------------------------------------------

## How to get better at testing?

-   Also get inspired by others!

-   Read testthat docs, the HTTP testing in R book, etc.

{{% note %}} Reading docs and learning to read the source of other packages is the recipe to success. Of course learning to ask for help is also important. {{% /note %}}

------------------------------------------------------------------------

## HTTP testing

-   vcr handy for usual workflows, and highly configurable.

-   Other HTTP testing packages: httptest, webfakes.

-   For databases, see dittodb!

------------------------------------------------------------------------

## Thank you, useR! team & participants!

Thanks in particular to Heather Turner (technical helper), Liz Hare (useR! accessibility team) and Yanina Bellini Saibene (global coordinator). And thanks to all other useR! volunteers!

{{% note %}} Thank you for participating! Let's tackle more questions before it's time to log off. {{% /note %}}

------------------------------------------------------------------------

## Questions

-   Right now if we have time.

-   In the lounge during the next days but asynchronously.

-   [rOpenSci forum](https://discuss.ropensci.org/), [RStudio community forum](https://community.rstudio.com/).

------------------------------------------------------------------------

