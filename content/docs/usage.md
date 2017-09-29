---
title: "Usage"
description: "How to run Rulehunter"
weight: 50
draft: false
toc: false
bref: "Rulehunter has a variety of ways that it can been used depending on a user's needs"
---

To processes the experiments in the `experimentsDir` directory specified in `config.yaml`, which is located in the current directory:
{{< highlight shell >}}
rulehunter
{{< /highlight >}}

To specify a config file:
{{< highlight shell >}}
rulehunter --config=/usr/local/rulehunter/config.yaml
{{< /highlight >}}

To run Rulehunter as a server continually checking and processing experiments:
{{< highlight shell >}}
rulehunter serve
{{< /highlight >}}

To install Rulehunter as an operating service (which then needs starting separately) using `/usr/local/rulehunter/config.yaml`:
{{< highlight shell >}}
rulehunter service install --config=/usr/local/rulehunter/config.yaml
{{< /highlight >}}

To uninstall Rulehunter as an operating service:
{{< highlight shell >}}
rulehunter service uninstall
{{< /highlight >}}

To get help:
{{< highlight shell >}}
rulehunter help
{{< /highlight >}}
