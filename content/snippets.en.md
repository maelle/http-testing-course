---
title: Snippets
weight: 1
hidden: true
chapter: false
disableToc: false
output: hugodown::md_document
rmd_hash: 9e13f228016b9c11

---

For copy-pasting during demos.

## Tests for `get_packages()`

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() works"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages"</span>, <span class='o'>&#123;</span>
    <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

with automatic cassette.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() error"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/skip_if_vcr_off.html'>skip_if_vcr_off</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages-error"</span>, <span class='o'>&#123;</span>
    <span class='nf'>expect_error</span><span class='o'>(</span><span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>, <span class='s'>"take off"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

with cassette

``` yaml
http_interactions:
- request:
    method: get
    uri: https://maelle.r-universe.dev/packages
    body:
      encoding: ''
      string: ''
    headers:
      Accept: application/json, text/xml, application/xml, */*
  response:
    status:
      status_code: 502
  recorded_at: 2021-05-27 13:44:41 GMT
  recorded_with: vcr/0.6.5.93, webmockr/0.8.0
```

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() retries"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/skip_if_vcr_off.html'>skip_if_vcr_off</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages-retry"</span>, <span class='o'>&#123;</span>
    <span class='nf'>expect_message</span><span class='o'>(</span><span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>, <span class='s'>"try"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span>
</code></pre>

</div>

with cassette

``` yaml
http_interactions:
- request:
    method: get
    uri: https://maelle.r-universe.dev/packages
    body:
      encoding: ''
      string: ''
    headers:
      Accept: application/json, text/xml, application/xml, */*
  response:
    status:
      status_code: 502
- request:
    method: get
    uri: https://maelle.r-universe.dev/packages
    body:
      encoding: ''
      string: ''
    headers:
      Accept: application/json, text/xml, application/xml, */*
  response:
    status:
      status_code: 200
      category: Success
      reason: OK
      message: 'Success: (200) OK'
    headers:
      server: nginx/1.18.0
      date: Thu, 27 May 2021 13:44:41 GMT
      content-type: application/json; charset=utf-8
      content-length: '180'
      connection: keep-alive
      x-powered-by: Express
      access-control-allow-origin: '*'
      etag: W/"b4-gNSpI8aK0mIGDXSgCPEFSExATo0"
    body:
      encoding: UTF-8
      file: no
      string: |-
        [
          "cransays",
          "crul",
          "goodpress",
          "hugodown",
          "lockedatapkg",
          "riem",
          "roblog",
          "rodev",
          "rtimicropem",
          "slugify",
          "tinkr",
          "vcr",
          "webmockr",
          "xml2"
        ]
  recorded_at: 2021-05-27 13:44:41 GMT
  recorded_with: vcr/0.6.5.93, webmockr/0.8.0
```

## `get_maintainers()`

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
  <span class='nf'>tibble</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/tibble/man/as_tibble.html'>as_tibble</a></span><span class='o'>(</span><span class='nv'>maintainers</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

## `get_packages2()`

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='c'>#' Packages</span>
<span class='c'>#'</span>
<span class='c'>#' @param universe universe to query</span>
<span class='c'>#'</span>
<span class='c'>#' @return A character vector.</span>
<span class='c'>#' @export</span>
<span class='c'>#'</span>
<span class='c'>#' @examples</span>
<span class='c'>#' \dontrun&#123;</span>
<span class='c'>#' get_packages2("ropensci")</span>
<span class='c'>#'&#125;</span>
<span class='nv'>get_packages2</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='nv'>universe</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>url</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/sprintf.html'>sprintf</a></span><span class='o'>(</span><span class='s'>"https://%s.r-universe.dev/packages"</span>, <span class='nv'>universe</span><span class='o'>)</span>
  <span class='nv'>token</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/Sys.getenv.html'>Sys.getenv</a></span><span class='o'>(</span><span class='s'>"SECRET_PLANET_TOKEN"</span><span class='o'>)</span>
  <span class='kr'>if</span> <span class='o'>(</span><span class='o'>!</span><span class='nf'><a href='https://rdrr.io/r/base/nchar.html'>nzchar</a></span><span class='o'>(</span><span class='nv'>token</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='kr'><a href='https://rdrr.io/r/base/stop.html'>stop</a></span><span class='o'>(</span><span class='s'>"Token for packages not found. See ?get_packages2"</span><span class='o'>)</span>
  <span class='o'>&#125;</span>

  <span class='nv'>resp</span> <span class='o'>&lt;-</span> <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/RETRY.html'>RETRY</a></span><span class='o'>(</span><span class='s'>"GET"</span>, <span class='nv'>url</span>,
    <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/add_headers.html'>add_headers</a></span><span class='o'>(</span><span class='s'>"Authorization"</span> <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste</a></span><span class='o'>(</span><span class='s'>"token"</span>, <span class='nv'>token</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span>
  <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/stop_for_status.html'>stop_for_status</a></span><span class='o'>(</span><span class='nv'>resp</span>, <span class='s'>"take off"</span><span class='o'>)</span>
  <span class='nv'>content</span> <span class='o'>&lt;-</span> <span class='nf'>httr</span><span class='nf'>::</span><span class='nf'><a href='https://httr.r-lib.org/reference/content.html'>content</a></span><span class='o'>(</span><span class='nv'>resp</span><span class='o'>)</span>
  <span class='nf'><a href='https://rdrr.io/r/base/unlist.html'>unlist</a></span><span class='o'>(</span><span class='nv'>content</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

vcr config in `tests/testthat/setup-applepie.R`

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='kr'><a href='https://rdrr.io/r/base/library.html'>library</a></span><span class='o'>(</span><span class='s'><a href='https://docs.ropensci.org/vcr'>"vcr"</a></span><span class='o'>)</span> <span class='c'># *Required* as vcr is set up on loading</span>
<span class='nf'><a href='https://rdrr.io/r/base/invisible.html'>invisible</a></span><span class='o'>(</span><span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/vcr_configure.html'>vcr_configure</a></span><span class='o'>(</span>
  dir <span class='o'>=</span> <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/vcr_test_path.html'>vcr_test_path</a></span><span class='o'>(</span><span class='s'>"fixtures"</span><span class='o'>)</span>,
  filter_request_headers <span class='o'>=</span> <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span><span class='o'>(</span>Authorization <span class='o'>=</span> <span class='s'>"not-my-secret-hehe"</span><span class='o'>)</span>
<span class='o'>)</span><span class='o'>)</span>
<span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/check_cassette_names.html'>check_cassette_names</a></span><span class='o'>(</span><span class='o'>)</span>
<span class='kr'>if</span> <span class='o'>(</span><span class='o'>!</span><span class='nf'><a href='https://rdrr.io/r/base/nchar.html'>nzchar</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/Sys.getenv.html'>Sys.getenv</a></span><span class='o'>(</span><span class='s'>"SECRET_PLANET_TOKEN"</span><span class='o'>)</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nf'><a href='https://rdrr.io/r/base/Sys.setenv.html'>Sys.setenv</a></span><span class='o'>(</span><span class='s'>"SECRET_PLANET_TOKEN"</span> <span class='o'>=</span> <span class='s'>"foobar"</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

Test itself

## Scheduled run

``` yaml
# For help debugging build failures open an issue on the RStudio community with the 'github-actions' tag.
# https://community.rstudio.com/new-topic?category=Package%20development&tags=github-actions
on:
  push:
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

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages2() works"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages2"</span>, <span class='o'>&#123;</span>
    <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages2</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

Test for error

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages2 errors well"</span>, <span class='o'>&#123;</span>
  <span class='nf'>withr</span><span class='nf'>::</span><span class='nf'><a href='https://withr.r-lib.org/reference/with_envvar.html'>local_envvar</a></span><span class='o'>(</span><span class='s'>"SECRET_PLANET_TOKEN"</span> <span class='o'>=</span> <span class='s'>""</span><span class='o'>)</span>
  <span class='nf'>expect_snapshot_error</span><span class='o'>(</span><span class='nf'>get_packages2</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

## Custom skipper

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nv'>skip_if_not_beyonce</span> <span class='o'>&lt;-</span> <span class='kr'>function</span><span class='o'>(</span><span class='o'>)</span> <span class='o'>&#123;</span>
  <span class='nv'>user</span> <span class='o'>&lt;-</span> <span class='nf'>whoami</span><span class='nf'>::</span><span class='nf'><a href='https://rdrr.io/pkg/whoami/man/username.html'>username</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='kr'>if</span> <span class='o'>(</span><span class='nv'>user</span> <span class='o'>==</span> <span class='s'>"beyonce"</span><span class='o'>)</span> <span class='o'>&#123;</span>
    <span class='kr'><a href='https://rdrr.io/r/base/function.html'>return</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/invisible.html'>invisible</a></span><span class='o'>(</span><span class='kc'>TRUE</span><span class='o'>)</span><span class='o'>)</span>
  <span class='o'>&#125;</span>
  <span class='nf'>skip</span><span class='o'>(</span><span class='s'>"Not Beyonce !"</span><span class='o'>)</span>
<span class='o'>&#125;</span></code></pre>

</div>

## Scheduled run

``` yaml
# For help debugging build failures open an issue on the RStudio community with the 'github-actions' tag.
# https://community.rstudio.com/new-topic?category=Package%20development&tags=github-actions
on:
  push:
    branches:
      - main
  schedule:
    - cron:  '0 12 * * *'

name: with-auth

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

