---
title: "Usage"
description: "How to run Rulehunter"
weight: 50
draft: false
toc: false
bref: "Rulehunter has a variety of ways that it can been used depending on a user's needs"
---

Rulehunter is run using the `rulehunter` executable created by `go install`.  You can use this command in a number of ways:

<br />
To processes the experiments in the `experimentsDir` directory specified in `config.yaml` located in the current directory:
{{< highlight shell >}}
rulehunter
{{< /highlight >}}

<br />
To run Rulehunter as a server continually checking and processing experiments:
{{< highlight shell >}}
rulehunter -serve
{{< /highlight >}}

<br />
To install Rulehunter as a service (which then needs starting separately) with `config.yaml` located in `/usr/local/rulehunter`:
{{< highlight shell >}}
rulehunter -install -configdir=/usr/local/rulehunter
{{< /highlight >}}
