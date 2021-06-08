---
title: Demo
weight: 1
output: hugodown::md_document
rmd_hash: 661bf4038e160ca1

---

## Test in case of an error

[Snippets](/snippets/#tests-for-get_packages)

-   `use_test("packages")`.

-   add snippets corresponding to error.

## Test in case of an error then success

[Snippets](/snippets/#tests-for-get_packages)

-   add snippets corresponding to error then success.

-   how to use a cassette interactively: source setup.R file, [`vcr::insert_cassette()`](https://docs.ropensci.org/vcr/reference/insert_cassette.html).

-   BACK TO SLIDES.

## Adding authentication

Note: Authentication is useless for R-universe but we'll pretend it's not!

[HTTP testing in R book chapter about security](https://books.ropensci.org/http-testing/security-chapter.html).

-   `edit_r_environ(scope = "project")`

-   `use_git_ignore(".Renviron")`

-   `setup.R` or `helper.R`?

-   BACK TO SLIDES.

