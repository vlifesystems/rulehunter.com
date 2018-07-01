### Single Run

To processes the experiments in the `experimentsDir` directory specified in `config.yaml`, which is located in the current directory:
``` bash
rulehunter
```

To specify a config file:
``` bash
rulehunter --config=/usr/local/rulehunter/config.yaml
```

To specify a single experiment file:
``` bash
rulehunter --file=experiments/diabetes.yaml
```

To ignore the `when` field in experiments and hence run experiments now:
``` bash
rulehunter --ignore-when
```

To get the version of Rulehunter:
``` bash
rulehunter version
```

To get help:
``` bash
rulehunter help
```

### Server

To run Rulehunter as a server continually checking and processing experiments:
``` bash
rulehunter serve
```

### Service

To install Rulehunter as an operating service (which then needs starting separately) using `/usr/local/rulehunter/config.yaml`:
``` bash
rulehunter service install --config=/usr/local/rulehunter/config.yaml
```

To uninstall Rulehunter as an operating service:
``` bash
rulehunter service uninstall
```
