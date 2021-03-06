Rulehunter is configured using a `config.yaml` file as follows:

``` yaml
# The location of the experiment files.
experimentsDir: "/usr/local/rulehunter/experiments"

# The location of the html files produced.
wwwDir: "/var/www/rulehunter"

# The location of the build files created while running. A temporary copy
# of each Dataset will be stored in a 'tmp' sub-directory while being
# processed.
buildDir: "/usr/local/rulehunter/build"

# The base URL for the html files produced.  This is so that you could for
# example base the Rulehunter generated site at '/rulehunter/' on an intranet.
# This uses the '<base>' html tag and therefore should have a trailing slash or
# refer to an html file.
# (default: /)
baseUrl: "http://intranet/rulehunter/"

# The maximum number of processes used to process the experiments.
# (default: -1, indicating the number of cpu's in the machine)
maxNumProcesses: 4

# The maximum number of records used from a data source.
# This is useful when creating and testing experiment files.
# (default: -1, indicating all the records)
maxNumRecords: 150

# A port to use for a simple static web server.
# This is only used when running as a server/service.
# (default: 0, indicating web server shouldn't run)
httpPort: 8780
```
