---
title: Preparation
weight: 1
output: hugodown::md_document
rmd_hash: 61838e6f5f975702

---

Thanks for registering to "GET better at testing your R package!".

I'll assume basic knowledge of package development, of GitHub and git, as well as basics of HTTP requests (having used httr or rvest, for instance).

Here are some setup instructions. Please email me at msmaellesalmon at gmail dot com with any question you may have!

## Online services

-   Create a [GitHub account](https://happygitwithr.com/big-picture.html) if you do not have one yet.

-   At <https://codecov.io> make sure you can log in with your GitHub account.

## System setup

-   `install.packages("devtools")`. [Setup chapter of the R packages book](https://r-pkgs.org/setup.html).

-   check: [`devtools::has_devel()`](https://rdrr.io/pkg/pkgbuild/man/has_compiler.html).

-   check: [`devtools::dev_sitrep()`](https://devtools.r-lib.org//reference/dev_sitrep.html).

-   check: [`usethis::git_sitrep()`](https://usethis.r-lib.org/reference/git_sitrep.html) (it has useful hints in case there are some problems).

-   optional, usethis and devtools setup: [usethis setup article](https://usethis.r-lib.org/articles/articles/usethis-setup.html).

-   `install.packages(c("vcr", "tibble", "withr", "httr", "jsonlite", "covr", "whoami"))`.

## Bonus if you have time

-   Generate a repository from [the template repository](https://github.com/ropensci-training/applepie) by clicking on the [green button "Use this template"](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template#creating-a-repository-from-a-template).

-   `usethis::create_from_github("YOUR-USER-NAME/applepie")`. This way you now have our starter package as a local RStudio project with an associated GitHub repository under your account.

See you soon at useR!

