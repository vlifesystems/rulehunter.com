---
title: "Configuration"
description: "How to configure Rulehunter"
weight: 30
draft: false
toc: false
bref: "Rulehunter is easy to configure using a single configuration file"
---

Rulehunter is configured using a `config.yaml` file as follows:
{{< highlight yaml >}}
# The location of the experiment files.
experimentsDir: "/usr/local/rulehunter/experiments"

# The location of the html files produced.
wwwDir: "/var/www/rulehunter"

# The location of the build files created while running.
buildDir: "/usr/local/rulehunter/build"

# The base URL for the html files produced.  This is so that you could for
# example base the Rulehunter generated site at '/rulehunter/' on an intranet.
# This uses the '<base>' html tag and therefore should have a trailing slash or
# refer to an html file.
# (default: /)
baseUrl: "http://intranet/rulehunter/"

# The maximum number of rules in a report.
# (default: 100)
maxNumReportRules: 50

# The maximum number of processes used to process the experiments.
# (default: -1, indicating the number of cpu's in the machine)
maxNumProcesses: 4

# The maximum number of records used from a data source.
# This is useful when creating and testing experiment files.
# (default: -1, indicating all the records)
maxNumRecords 150

# The maximum number of records to cache from a data source.
# This will speed up access to a data source, particularly if being
# accessed over a network.
# (default: 0, indicating no caching)
maxNumCacheRecords 500000
{{< /highlight >}}