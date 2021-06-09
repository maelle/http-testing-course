---
title: Demo
weight: 1
output: hugodown::md_document
rmd_hash: 795f932b8c731b9c

---

## Test in case of an error

[Snippets](/snippets/#tests-for-get_packages)

-   `use_test("packages")`.

-   add snippets corresponding to error.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'>
<span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages() error"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/skip_if_vcr_off.html'>skip_if_vcr_off</a></span><span class='o'>(</span><span class='o'>)</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages-error"</span>, <span class='o'>&#123;</span>
    <span class='nf'>expect_error</span><span class='o'>(</span><span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>, <span class='s'>"take off"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

with cassette `packages-error.yml`

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

## Test in case of an error then success

[Snippets](/snippets/#tests-for-get_packages)

-   add snippets corresponding to error then success.

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

with cassette `packages-retry.yml`

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

-   how to use a cassette interactively: source setup.R file, [`vcr::insert_cassette()`](https://docs.ropensci.org/vcr/reference/insert_cassette.html).

-   BACK TO SLIDES.

## Adding authentication

Note: Authentication is useless for R-universe but we'll pretend it's not!

[HTTP testing in R book chapter about security](https://books.ropensci.org/http-testing/security-chapter.html).

-   `use_r("packages2")`.

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

-   `edit_r_environ(scope = "project")` to add (empty line at the end needed)

<!-- -->

    SECRET_PLANET_TOKEN="top-secret-token"

-   `use_git_ignore(".Renviron")`

-   `use_test("packages2")`

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'>test_that</span><span class='o'>(</span><span class='s'>"get_packages2() works"</span>, <span class='o'>&#123;</span>
  <span class='nf'>vcr</span><span class='nf'>::</span><span class='nf'><a href='https://docs.ropensci.org/vcr/reference/use_cassette.html'>use_cassette</a></span><span class='o'>(</span><span class='s'>"packages2"</span>, <span class='o'>&#123;</span>
    <span class='nv'>pkgs</span> <span class='o'>&lt;-</span> <span class='nf'>get_packages</span><span class='o'>(</span><span class='s'>"maelle"</span><span class='o'>)</span>
  <span class='o'>&#125;</span><span class='o'>)</span>
  <span class='nf'>expect_vector</span><span class='o'>(</span><span class='nv'>pkgs</span>, <span class='nf'><a href='https://rdrr.io/r/base/character.html'>character</a></span><span class='o'>(</span><span class='o'>)</span><span class='o'>)</span>
<span class='o'>&#125;</span><span class='o'>)</span></code></pre>

</div>

-   Oh no our secret is in the cassette `packages2.yml`!

-   Delete the cassette `packages2.yml`.

-   vcr config in `tests/testthat/setup-applepie.R`

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

-   [`setup.R` or `helper.R`](https://blog.r-hub.io/2020/11/18/testthat-utility-belt/#code-called-in-your-tests)?

-   BACK TO SLIDES.

