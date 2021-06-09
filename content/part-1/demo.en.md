---
title: Demo
weight: 2
output: hugodown::md_document
rmd_hash: 58fc888745bf433e

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

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() works"</span>, <span class='o'>&#123;</span>
  <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

-   [`devtools::test()`](https://devtools.r-lib.org//reference/test.html) or test button on the file or test via the build panel. Possibility to set keyboard shortcuts.

-   [`covr::report()`](http://covr.r-lib.org/reference/report.html).

-   Add a new function `use_r("maintainers")`, `use_package("withr")`, `use_package("tibble")`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'>#' Maintainers</span>
<span class='c'>#'</span>
<span class='c'>#' @inheritParams get_packages</span>
<span class='c'>#'</span>
<span class='c'>#' @return A character vector.</span>
<span class='c'>#' @export</span>
<span class='c'>#'</span>
<span class='c'>#' @examples</span>
<span class='c'>#' get_maintainers("ggseg")</span>
<span class='nv'>get_maintainers</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='nv'>universe</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>url</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/sprintf.html'>sprintf</a></span><span class='o'>(</span><span class='s'>"https://%s.r-universe.dev/stats/maintainers"</span>, <span class='nv'>universe</span><span class='o'>)</span>
  <span class='nv'>resp</span> <span class='o'>&lt;-</span> <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/GET.html'>GET</a></span><span class='o'>(</span><span class='nv'>url</span><span class='o'>)</span>
  <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/stop_for_status.html'>stop_for_status</a></span><span class='o'>(</span><span class='nv'>resp</span><span class='o'>)</span>
  <span class='nv'>content</span> <span class='o'>&lt;-</span> <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/content.html'>content</a></span><span class='o'>(</span><span class='nv'>resp</span><span class='o'>)</span>
  <span class='nv'>temp_file</span> <span class='o'>&lt;-</span> <span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_tempfile.html'>local_tempfile</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='nf'><a href='https://rdrr.io/r/base/writeLines.html'>writeLines</a></span><span class='o'>(</span><span class='nv'>content</span>, <span class='nv'>temp_file</span><span class='o'>)</span>
  <span class='nv'>maintainers</span> <span class='o'>&lt;-</span> <span class='nf'>jsonlite</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/jsonlite/man/stream_in.html'>stream_in</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/connections.html'>file</a></span><span class='o'>(</span><span class='nv'>temp_file</span><span class='o'>)</span>, verbose <span class='o'>=</span> <span class='kc'>FALSE</span><span class='o'>)</span>
  <span class='nf'>tibble</span><span class='nf'>::</span><span class='nf'><a href='https://tibble.tidyverse.org/reference/as_tibble.html'>as_tibble</a></span><span class='o'>(</span><span class='nv'>maintainers</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

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

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() works"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages"</span>, <span class='o'>&#123;</span>
    <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

-   BACK TO SLIDES.

[^1]: Why applepie? `{=html} {{< tweet 1397948070378225670 >}}`

