---
title: Demo
weight: 2
output: hugodown::md_document
rmd_hash: 3178b0ef06bcc70d

---

## System setup

Check where we all are compared to [the instructions](/part-1/system-prep).

## Discover our example package

-   For info, [R-universe API docs](https://ggseg.r-universe.dev/ui#api).

-   Generate a repository from [the template repository](https://github.com/ropensci-training/applepie)[^1]

-   `usethis::create_from_github("YOURUSERNAME/applepie")`.

-   Open RStudio project.

-   Optional: look for occurrences of "maelle" (README, DESCRIPTION) and replace them with your username.

-   [`devtools::load_all()`](https://devtools.r-lib.org//reference/load_all.html)

-   `get_packages("ggseg")`

-   [`devtools::check()`](https://devtools.r-lib.org//reference/check.html)

-   [`usethis::use_mit_license()`](https://usethis.r-lib.org/reference/licenses.html)

-   [`devtools::check()`](https://devtools.r-lib.org//reference/check.html)

## Add cute little tests

-   [`usethis::use_testthat()`](https://usethis.r-lib.org/reference/use_testthat.html)

-   `usethis::use_test("packages")` ([testthat expectations](https://testthat.r-lib.org/reference/index.html))

-   [`devtools::test()`](https://devtools.r-lib.org//reference/test.html) or test button on the file or test via the build panel. Possibility to set keyboard shortcuts.

-   [`covr::report()`](http://covr.r-lib.org/reference/report.html).

-   Add a new function `use_r("maintainers")`, `use_package("withr")`, `use_package("tibble")`.

-   [`covr::report()`](http://covr.r-lib.org/reference/report.html).

## Add continuous integration

-   [`usethis::use_github_action_check_standard()`](https://usethis.r-lib.org/reference/use_github_action.html)

-   `use_coverage()`

-   `usethis::use_github_action("test-coverage-pak")`

-   BACK TO SLIDES.

## Start using vcr

-   [`vcr::use_vcr()`](https://docs.ropensci.org/vcr/reference/use_vcr.html)

-   Read example test, delete it.

-   Insert `vcr::use_cassette("packages")` in a test. Have a look at the files added. If this were not an online tutorial, turn off wifi and run the test again, it works!

-   BACK TO SLIDES.

[^1]: Why applepie? `{=html} {{< tweet 1397948070378225670 >}}`

