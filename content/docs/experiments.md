### An Experiment file

An _experiment_ is what describes the dataset that you want to process and what you want the generated rules to aim for.  Each experiment is described by a `.yaml` or a `.json` file located in the `experimentsDir` of `config.yaml`.  This will look as follows:

``` yaml
# The title of the report
title: "What would indicate good flow?"

# The category that this report is in
category: "acme"

# The tags associated with the report
tags:
  - test
  - "household sewage"

train:
  # The dataset to used to train the rule discovery process
  dataset:
    # Describe a CSV dataset
    csv:
      # The name of the CSV file
      filename: "fixtures/flow.csv"
      # Whether the CSV file contains a header line
      hasHeader: true
      # What separator the CSV file is using
      separator:  ","
    # The names of the fields to be used
    fields:
      - group
      - district
      - height
      - flow
  # When to run the experiment's train mode (default: !hasRun)
  when: "!hasRunToday || sinceLastRunHours > 2"


test:
  # An optional dataset used to test the rules generated from the train dataset
  dataset:
    # Describe an SQL connection
    sql:
      # The name of the driver to use (mssql, mysql, postgres, sqlite3)
      driverName: "mssql"
      # The details of the data source
      dataSourceName: "Server=127.0.0.1;Port=1433;Database=master;UID=sa,PWD=letmein"
      # An SQL query to run on the data source to create the dataset
      query: "select * from flow"
    # The names of the fields to be used
    fields:
      - group
      - district
      - height
      - flow
  # When to run the experiment's test mode (default: !hasRun)
  when: "!hasRunToday || sinceLastRunMinutes > 20"

# Describe rule generation
ruleGeneration:
  # The fields that can be used in the rules
  fields:
    - group
    - district
    - height
  # Whether arithmetic rules should be generated
  arithmetic: true
  # The maximum number of rules that can be combined together to form
  # another rule
  combinationLength: 3

# Describe aggregators
aggregators:
    # The name of the aggregator
  - name: "goodFlowMCC"
    # The kind of aggregator to use
    # (calc, count, mcc, mean, precision, recall, sum)
    kind: "mcc"
    # The argument to pass to the aggregator function
    arg:  "flow > 60"

# What goals to try to achieve
goals:
  - "goodFlowMCC > 0"

# The order to sort the rules in
sortOrder:
  - aggregator: "goodFlowMCC"
    direction:  "descending"
  - aggregator: "numMatches"
    direction:  "descending"

# User defined rules to try
rules:
  - "height > 10"
  - "height > 10 && height < 20"
```

### SQL
For more information about `dataSourceName` see the following for each `driverName`:

* `mssql` - MS SQL Server - [README](https://github.com/denisenkom/go-mssqldb/blob/master/README.md).
* `mysql` - MySQL - [README](https://github.com/go-sql-driver/mysql#dsn-data-source-name).
* `postgres` - PostgreSQL - [GoDoc](https://godoc.org/github.com/lib/pq#hdr-Connection_String_Parameters).
* `sqlite3` - sqlite3 - This just uses the filename of the database.

<em>For security reasons any user specified for an SQL source should only have read access to the tables/database as the queries can't be checked for safety.</em>

### Aggregators

The aggregators are used to collect data on the records that match against a rule.  There are the following functions:

<br />
<table class="table table-bordered">
  <tr><th>Function</th><th>Description</th></tr>
  <tr>
    <td><code>calc(expr)</code</td>
    <td>Calculate the result of expression using as variables any aggregatorNames used in the expressiona</td>
  </tr>
  <tr>
    <td><code>count(expr)</code></td>
    <td>Count the number of records that match a rule and the supplied expression</td>
  </tr>
  <tr>
    <td><code>mcc(expr)</code></td>
    <td>Calculate the <a href="https://en.wikipedia.org/wiki/Matthews_correlation_coefficient">Matthews correlation coefficient</a> of a rule to match against the expression passed.  A coefficient of +1 represents a perfect prediction, 0 no better than random prediction and −1 indicates total disagreement between prediction and observation.</td>
  </tr>
  <tr>
    <td><code>mean(expr)</code></td>
    <td>Calculate the mean value for an expression calculated on records that match a rule</td>
  </tr>
  <tr>
    <td><code>precision(expr)</code></td>
    <td>Calculate the <a href="https://en.wikipedia.org/wiki/Precision_and_recall">precision</a> of a rule to match against the expression passed</td>
  </tr>
  <tr>
    <td><code>recall(expr)</code></td>
    <td>Calculate the <a href="https://en.wikipedia.org/wiki/Precision_and_recall">recall</a> of a rule to match against the expression passed</td>
  </tr>
  <tr>
    <td><code>sum(expr)</code></td>
    <td>calculates the sum for an expression calculated on records that match a rule</td>
  </tr>
</table>


### Sort Order

The rules in the report are sorted in the order of the entries for the `sortOrder` field.  The aggregators that can be used are the names specified in the `aggregators` field as well as the following built-in aggregators.

<br />
<table class="table table-bordered">
  <tr><th>Aggregator</th><th>Description</th></tr>
  <tr>
    <td><code>numMatches</code></td>
    <td>The number of records that a rule matches against</td>
  </tr>
  <tr>
    <td><code>percentMatches</code></td>
    <td>The percent of records in the dataset that a rule matches against</td>
  </tr>
  <tr>
    <td><code>goalsScore</code></td>
    <td>How well a rule passes the goals.  The higher the number the better the match</td>
  </tr>
</table>


### When Expressions

The `when` field determines when the experiment is to be run and how often.  It is an expression that supports the following variables:

<br />
<table class="table table-bordered">
  <tr><th>Variable</th><th>Description</th></tr>
  <tr>
    <td><code>hasRun</code></td>
    <td>Whether the experiment has been ever been run</td>
  </tr>
  <tr>
    <td><code>hasRunToday</code></td>
    <td>Whether the experiment has been run today</td>
  </tr>
  <tr>
    <td><code>hasRunThisWeek</code></td>
    <td>Whether the experiment has been run this week</td>
  </tr>
  <tr>
    <td><code>hasRunThisMonth</code></td>
    <td>Whether the experiment has been run this month</td>
  </tr>
  <tr>
    <td><code>hasRunThisYear</code></td>
    <td>Whether the experiment has been run this year</td>
  </tr>
  <tr>
    <td><code>sinceLastRunMinutes</code></td>
    <td>The number of minutes since the experiment was last run</td>
  </tr>
  <tr>
    <td><code>sinceLastRunHours</code></td>
    <td>The number of hours since the experiment was last run</td>
  </tr>
  <tr>
    <td><code>isWeekday</code></td>
    <td>Whether today is a weekday</td>
  </tr>
</table>

### Expressions

Any expressions used in the experiment file conform to fairly standard Go expressions and can use the following functions:


<table class="table table-bordered">
  <tr><th>Function</th><th>Description</th></tr>
  <tr>
    <td><code>if(b, t, f)</code></td>
    <td>Return <code>t</code> if <code>b</code> is true, otherwise returns <code>f</code></td>
  </tr>
  <tr>
    <td><code>iferr(v, av)</code></td>
    <td>Return <code>v</code> if not an error, otherwise return <code>av</code></td>
  </tr>
  <tr>
    <td><code>in(n, h ...)</code></td>
    <td>Return whether <code>n</code> is in the rest of the arguments</td>
  </tr>
  <tr>
    <td><code>ni(n, h ...)</code></td>
    <td>Return whether <code>n</code> is not in the rest of the arguments</td>
  </tr>
  <tr>
    <td><code>max(n ...)</code></td>
    <td>Return the biggest number supplied</td>
  </tr>
  <tr>
    <td><code>min(n ...)</code></td>
    <td>Return the smallest number supplied</td>
  </tr>
  <tr>
    <td><code>pow(b, e)</code></td>
    <td>Raise <code>b</codeL to power of <code>e</code></td>
  </tr>
  <tr>
    <td><code>roundto(n, p)</code></td>
    <td>Round <code>n</code> to <code>p</code> decimal places</td>
  </tr>
  <tr>
    <td><code>sqrt(x)</code></td>
    <td>Return the square root of <code>x</code></td>
  </tr>
</table>
