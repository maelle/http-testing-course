---
outputs:
- Reveal
title: GET more tips
hidden: true
layout: list
weight: 11
output: hugodown::md_document
countdown: true
rmd_hash: 7735db444260cb8c

---

<div class="highlight">

</div>

## Test more things

-   what if the web API is down?

-   what if it fails for a bit then is up again?

{{% note %}} We want to test the behavior of our package not only when things are well on the API side. {{% /note %}}

------------------------------------------------------------------------

## We can't trigger an error...

but we can mock or fake them!

Two approaches with vcr

-   complementing with the webmockr package; :slightly_smiling_face:

-   editing cassettes. :grin:

{{% note %}} We have to fake API errors. There are two ways to do this when using vcr: one is to use another package, the webmockr package; another one that I find more natural is to edit or write fake cassettes from scratch. We will use the second approach today but the first one is documented both in the HTTP testing in R book as well as vcr docs. {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

{{% note %}} Let's go to RStudio. {{% /note %}}

------------------------------------------------------------------------

## Amending a vcr cassette

Importance of [`vcr::skip_if_vcr_off()`](https://docs.ropensci.org/vcr/reference/skip_if_vcr_off.html). Amending itself:

-   Start from an actual cassette;

-   Edit and delete.

Easier than starting from scratch!

{{% note %}} We have seen how to create tests in case of API errors by using fake cassettes. {{% /note %}}

------------------------------------------------------------------------

## Authentication gymnastics

Say the API need a secret...

-   How to NOT leak it?

-   How to have tests pass in external pull requests?

{{% note %}} A big challenge when interacting with web resources is the infrastructure for secrets. API keys, OAuth tokens etc. Today we will use a simple example. {{% /note %}}

------------------------------------------------------------------------

## Security mindset

-   What are the secrets your package use? API keys?

-   Use special accounts for testing if possible.

-   Where do secrets live? Headers? Files?

-   Learn how to keep secrets safe, double-check.

-   Learn how to handle mistakes. (:speak_no_evil: I recently leaked my own GitHub PAT!)

{{% note %}} I am NOT a security expert, here's my approach. You are learning from the best as I leaked my own GitHub PAT whilst writing the HTTP testing in R book! {{% /note %}}

------------------------------------------------------------------------

## Demo :rocket:

{{% note %}} Time for a demo. {{% /note %}}

------------------------------------------------------------------------

## Secrets & vcr

-   Know your secrets well;

-   Know the tools well;

-   Some logic in setup.R and secrets as GitHub repo secrets.

[HTTP testing in R book chapter about security](https://books.ropensci.org/http-testing/security-chapter.html).

{{% note %}} A big part of the approach to handle secrets is knowing both the secrets and tools well. What are the secrets, how are they passed, could they end up in a test fixture, how to prevent that, etc. We then need to add some logic in a testthat helper file. Secrets can be stored as GitHub repo secrets but for now we have not added any continuous integration workflow that uses secrets. We'll do that later though! {{% /note %}}

------------------------------------------------------------------------

## Time for a break! :coffee:

<!--html_preserve-->

<div id="timer_hugo" class="countdown" style="top:100;left:0;" data-warnwhen="0">

<code class="countdown-time"><span class="countdown-digits minutes">05</span><span class="countdown-digits colon">:</span><span class="countdown-digits seconds">00</span></code>

</div>

<!--/html_preserve-->

