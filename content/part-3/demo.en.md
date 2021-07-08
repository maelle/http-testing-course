---
title: Demo
weight: 1
output: hugodown::md_document
rmd_hash: 80e7d52de84e8d43

---

## Snapshot testing

[testthat snapshot testing vignette](https://testthat.r-lib.org/articles/snapshotting.html).

-   Add an error snapshot test for `get_packages2()`.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages2 errors well"</span>, <span class='o'>&#123;</span>
  <span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_envvar.html'>local_envvar</a></span><span class='o'>(</span><span class='s'>"SECRET_PLANET_TOKEN"</span> <span class='o'>=</span> <span class='s'>""</span><span class='o'>)</span>
  <span class='nf'>expect_snapshot_error</span><span class='o'>(</span><span class='nf'>get_packages2</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

-   Modify the [error message](https://style.tidyverse.org/error-messages.html), re-run the test.

## Custom skipper

[testthat skipping vignette](https://testthat.r-lib.org/articles/skipping.html)

-   Add custom skipper in `setup.R` (or another testthat helper file)

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nv'>skip_if_not_beyonce</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>user</span> <span class='o'>&lt;-</span> <span class='nf'>whoami</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/whoami/man/username.html'>username</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='kr'>if</span> <span class='o'>(</span><span class='nv'>user</span> <span class='o'>==</span> <span class='s'>"beyonce"</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='kr'><a href='https://rdrr.io/r/base/function.html'>return</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/invisible.html'>invisible</a></span><span class='o'>(</span><span class='kc'>TRUE</span><span class='o'>)</span><span class='o'>)</span>
  <span class='o'>&#125;</span>
  <span class='nf'>skip</span><span class='o'>(</span><span class='s'>"Not Beyonce !"</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

-   Add whoami as dependency. `usethis::use_package("whoami", type = "Suggests")`

-   Use it in a new test

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() works"</span>, <span class='o'>&#123;</span>
  <span class='nf'>skip_if_not_beyonce</span><span class='o'>(</span><span class='o'>)</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"blabla"</span>, <span class='o'>&#123;</span>
    <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

-   BACK TO SLIDES.

## Scheduled CI run with real requests

-   Add [secret to GitHub repo](https://docs.github.com/en/actions/reference/encrypted-secrets).

-   Adding a workflow with scheduled weekly runs with vcr turned off.

``` yaml
# For help debugging build failures open an issue on the RStudio community with the 'github-actions' tag.
# https://community.rstudio.com/new-topic?category=Package%20development&tags=github-actions
on:
  push:
    branches:
      - main
  schedule:
    - cron:  '0 12 * * *'

name: R-CMD-check

jobs:
  R-CMD-check:
    runs-on: ${{ matrix.config.os }}

    name: ${{ matrix.config.os }} (${{ matrix.config.r }})

    strategy:
      fail-fast: false
      matrix:
        config:
          - {os: windows-latest, r: 'release'}
          - {os: macOS-latest, r: 'release'}
          - {os: ubuntu-20.04, r: 'release', rspm: "https://packagemanager.rstudio.com/cran/__linux__/focal/latest"}
          - {os: ubuntu-20.04,   r: 'devel', rspm: "https://packagemanager.rstudio.com/cran/__linux__/focal/latest", http-user-agent: "R/4.1.0 (ubuntu-20.04) R (4.1.0 x86_64-pc-linux-gnu x86_64 linux-gnu) on GitHub Actions" }

    env:
      R_REMOTES_NO_ERRORS_FROM_WARNINGS: true
      RSPM: ${{ matrix.config.rspm }}
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      VCR_TURN_OFF: true
      SECRET_PLANET_TOKEN: ${{ secrets.SECRET_PLANET_TOKEN }}

    steps:
      - uses: actions/checkout@v2

      - uses: r-lib/actions/setup-r@v1
        with:
          r-version: ${{ matrix.config.r }}

      - uses: r-lib/actions/setup-pandoc@v1

      - name: Query dependencies
        run: |
          install.packages('remotes')
          saveRDS(remotes::dev_package_deps(dependencies = TRUE), ".github/depends.Rds", version = 2)
          writeLines(sprintf("R-%i.%i", getRversion()$major, getRversion()$minor), ".github/R-version")
        shell: Rscript {0}

      - name: Restore R package cache
        uses: actions/cache@v2
        with:
          path: ${{ env.R_LIBS_USER }}
          key: ${{ runner.os }}-${{ hashFiles('.github/R-version') }}-1-${{ hashFiles('.github/depends.Rds') }}
          restore-keys: ${{ runner.os }}-${{ hashFiles('.github/R-version') }}-1-

      - name: Install system dependencies
        if: runner.os == 'Linux'
        run: |
          while read -r cmd
          do
            eval sudo $cmd
          done < <(Rscript -e 'writeLines(remotes::system_requirements("ubuntu", "20.04"))')

      - name: Install dependencies
        run: |
          remotes::install_deps(dependencies = TRUE)
          remotes::install_cran("rcmdcheck")
        shell: Rscript {0}

      - name: Check
        env:
          _R_CHECK_CRAN_INCOMING_REMOTE_: false
        run: |
          options(crayon.enabled = TRUE)
          rcmdcheck::rcmdcheck(args = c("--no-manual", "--as-cran"), error_on = "warning", check_dir = "check")
        shell: Rscript {0}

      - name: Upload check results
        if: failure()
        uses: actions/upload-artifact@main
        with:
          name: ${{ runner.os }}-r${{ matrix.config.r }}-results
          path: check
```

-   [Line of a workflow file only enabling a job for push & internal PRs](https://github.com/r-lib/pkgdown/blob/900ef5471576f8f29508a7e7d94fae51390f2d96/.github/workflows/pkgdown.yaml#L15).

-   BACK TO SLIDES.

