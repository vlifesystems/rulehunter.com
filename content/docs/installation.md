---
title: "Installation"
description: "Installation is easy"
weight: 20
draft: false
toc: false
bref: "Installation is easy on a wide variety of platforms"
---


Rulehunter is written in [Go](https://golang.org) and therefore to compile Rulehunter you must first Download and install Go.  Rulehunter is then fetched, compiled and installed with:
{{< highlight shell >}}
go get github.com/vlifesystems/rulehunter
go install
{{< /highlight >}}

There are several files needed to render the html properly these are located in the `support/` directory.

### Twitter Bootstrap
Copy directories from `support/bootstrap` to the `wwwDir` directory specified in `config.yaml`.

### jQuery
Copy directory `support/jquery/js` to the `wwwDir` directory specified in `config.yaml`.

### Html5 Shiv
Copy directory `support/html5shiv/js` to the `wwwDir` directory specified in `config.yaml`.

### Rulehunter
Copy directories from `support/rulehunter` to the `wwwDir` directory specified in `config.yaml`.
