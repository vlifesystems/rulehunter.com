## Using the Examples
The example experiments demonstrate well how Rulehunter works.  Once you have run them you can tinker with them and compare the results.

### Preparing the `www` Directory
Before running `rulehunter` on the experiments you need to initialize the
`www` directory.

For Linux/MacOS:

``` bash
chmod +x examples/bin/init_www_unix.sh
examples/bin/init_www_unix.sh
```

For Windows:

``` bash
examples\bin\init_www_windows.bat
```

### Processing the Experiments

To process the experiments run `rulehunter` from the `examples/` directory:

``` bash
rulehunter
```

To process a single experiment run `rulehunter` with the `--file` flag from the `examples/` directory.  For example to process the `experiments/iris-setosa.yaml` file run:

``` bash
rulehunter --file=experiments/iris-setosa.yaml
```

The website will be generated in the `examples/www` directory and can
be viewed with a simple static webserver such as the following run from
the `examples/www` directory:

``` bash
ruby -run -ehttpd . -p8780
```

If you don't like ruby there is this [list of one-liner static webservers](https://gist.github.com/willurd/5720255).

#### Running as a server

If you run Rulehunter as a server/service then it can start a simple static web server for you.  The default `config.yaml` in the `examples/` directory is configured to set this up on port: 8780.  Therefore you can point a web browser to [http://localhost:8780](http://localhost:8780) to see the website.  If this port is already being used then you can change it from within the config file.

``` bash
rulehunter serve
```
