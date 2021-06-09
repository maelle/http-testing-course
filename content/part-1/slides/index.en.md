---
outputs:
- Reveal
title: GET started
hidden: true
layout: list
weight: 11
output: hugodown::md_document
countdown: true
rmd_hash: ae7413ed6a6cb898

---

<div class="highlight">

</div>

# GET better at testing your package!

:wave: Bonjour !

{{% note %}} Hello and thank you for coming! {{% /note %}}

------------------------------------------------------------------------

## Why test your package?

{{< tweet 1085238646100451329 >}}

{{% note %}} Sharla Gelfand: "wow who knew there was actually a robust way to test functions besides trying random examples and seeing if they work and then not remembering them once you clear your console" This funny tweet is very encouraging as it shows using actual testing tools will simplify your work. {{% /note %}}

------------------------------------------------------------------------

## Why test your package?

{{< tweet 1043307291909316609 >}}

{{% note %}} Jenny Bryan: "If you use software that lacks automated tests, you are the tests.". This other tweet justifies testing as a responsability you have towards your user. {{% /note %}}

------------------------------------------------------------------------

## Why test your package?

[rOpenSci guidance for package development](https://devguide.ropensci.org/building.html#testing).

> All packages should have a test suite that covers major functionality of the package. The tests should also cover the behavior of the package in case of errors.

{{% note %}} rOpenSci dev guide, which we could subjectively view as a reference, recommends testing. {{% /note %}}

------------------------------------------------------------------------

## Why test your package?

[rOpenSci guidance for package development](https://devguide.ropensci.org/building.html#testing).

> It is good practice to write unit tests for all functions, and all package code in general, ensuring key functionality is covered. Test coverage below 75% will likely require additional tests or explanation before being sent for review.

{{% note %}} We even have an arbitrary coverage limit. We will see how to get the test coverage for packages. {{% /note %}}

------------------------------------------------------------------------

## How to test?

-   Set up via [`usethis::use_testthat()`](https://usethis.r-lib.org/reference/use_testthat.html) (once per package) and [`usethis::use_test()`](https://usethis.r-lib.org/reference/use_r.html) (once per test file).

-   Formalize your *random examples.*

{{% note %}} A simple workflow to get started. {{% /note %}}

------------------------------------------------------------------------

## Now what?

> Testing is often demonstrated with cute little tests and functions where all the inputs and expected results can be inlined. But in real packages, things aren't always so simple

Jenny Bryan in a [testthat vignette](https://testthat.r-lib.org/articles/test-fixtures.html#test-fixtures).

{{% note %}} A smart remark by Jenny Bryan, as usual. {{% /note %}}

------------------------------------------------------------------------

## Now what?

Today we will explore less cute tests. :ghost:

<div class="highlight">

{{< figure src="5583535.jpeg" alt="Oatmeal cookies decorated as monsters" caption="Picture by [Daisy Anderson on Pexels](https://www.pexels.com/photo/brown-cookies-with-different-designs-5583535/)." width="300" >}}

</div>

{{% note %}} Today we'll try to bridge the gap between cute tests and reality! {{% /note %}}

------------------------------------------------------------------------

## HTTP things are hard to test

-   Slow tests?
-   Overburdening the web resource?
-   Using credits for testing?
-   Impossible to trigger errors?

Good use case for learning more about testing techniques! :tada:

{{% note %}} The challenges of HTTP testing are a blessing in disguise. {{% /note %}}

------------------------------------------------------------------------

## Our goals today

Gaining specific knowledge about HTTP testing via vcr, general knowledge about testing R packages with testthat!

{{% note %}} We have an exciting program! {{% /note %}}

------------------------------------------------------------------------

## Website tour

:link: <https://http-testing-r.netlify.app/>

{{% note %}} To be shown: slides, demo, snippets, search, repo. {{% /note %}}

------------------------------------------------------------------------

## Get to know `applepie`

Client for R-universe API. :rocket:

[rOpenSci comm call about R-universe](https://ropensci.org/commcalls/may2021-r-universe/).

> R-universe is new a platform by rOpenSci for publishing and discovering R packages, Rmd articles, and other R based content.

And it has an [API](https://ggseg.r-universe.dev/ui#api)! :tada:

{{% note %}} We will use the API of the cool R-universe project as a playground. The R-universe project will be presented in my colleague Jeroen Ooms' keynote. Today we only need to know it's a cool platform for distributing software, whose metadata is available via an API. {{% /note %}}

------------------------------------------------------------------------

## Demo

:package: Load, use, check our (cute?) little package.

:hatched_chick: Add a cute little test to it.

:umbrella: Explore its test coverage.

:traffic_light: Set up continuous integration.

{{% note %}} We'll first do a few quote simple quote things with our package, so we all get set up. We'll then be ready to add HTTP tests. {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

{{% note %}} Time for a demo. {{% /note %}}

------------------------------------------------------------------------

## Back from the demo

A package with two functions, non zero test coverage, continuous integration... :bouquet:

But what if our internet connection gets fragile? :scream:

{{% note %}} We are at a good development stage, but we need to get to the heart of today's topic. {{% /note %}}

------------------------------------------------------------------------

## Test fixtures

> "A test fixture is an environment used to consistently test some item, device, or piece of software."

[Wikipedia](https://en.wikipedia.org/wiki/Test_fixture) via [testthat "test fixtures" vignette](https://testthat.r-lib.org/articles/test-fixtures.html#test-fixtures).

{{% note %}} A fixtures can be options, environment variables, data. {{% /note %}}

------------------------------------------------------------------------

## Text fixtures in general in R

<div class="fragment">

-   `withr` :heart_eyes: e.g. [`withr::local_options()`](https://withr.r-lib.org/reference/with_options.html). Change then clean!

</div>

<div class="fragment">

-   Put example data you put in `tests/testthat/test-data`, locate it in tests via `testthat::test_path("test-data")`.

</div>

{{% note %}} Even before using a specific HTTP testing package it is important we know about withr, and where to put test data in general. {{% /note %}}

------------------------------------------------------------------------

## What about fixtures for HTTP testing?

:bulb: How about we create a test fixture with stored or faked API responses?

This is the idea behind *vcr* and *httptest*. (*webfakes* is a bit different).

Let's try *vcr*!

{{% note %}} Introduce the idea of mocking HTTP interactions. webfakes provides a way to define a whole web server so it's a bit different; useful in some cases for sure. Today we will concentrate on vcr. {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

{{% note %}} Time for a demo. {{% /note %}}

------------------------------------------------------------------------

## Back from the demo

Now our package has a test that can work when internet is down.

{{% note %}} We have added vcr infrastructure (a dependency on vcr, a testthat setup file) and a test using vcr (that created a cassette which is a file where HTTP interactions i.e. requests and responses, are recorded on disk). {{% /note %}}

------------------------------------------------------------------------

## Time for a break! :coffee:

<!--html_preserve-->

<div id="timer_hugo" class="countdown" style="top:100;left:0;" data-warnwhen="0">

<code class="countdown-time"><span class="countdown-digits minutes">05</span><span class="countdown-digits colon">:</span><span class="countdown-digits seconds">00</span></code>

</div>

<!--/html_preserve-->

{{% note %}} 5 minutes break. {{% /note %}}

