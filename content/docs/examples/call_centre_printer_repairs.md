---
title: "A Call Centre: Printer Repairs"
description: "A call centre selling printer repair contracts for its client"
weight: 60
draft: false
toc: true
bref: "An example of a call centre trying to balance its needs with those of their client"
---

### Outline

A call centre is representing a client that wants to offer a repair contract to customers who have bought printers from them in the past.  The call centre needs to balance its need to make a profit with the needs of their client.

#### The client's requirements

  * The ROI (Return On Investment) must be at least 2.0
  * At least 25% of contacts must result in a repair contract
  * They would like the total value of contracts to be as high as possible

#### The call centre's requirements

  * The ROI for the call centre needs to be at least 1.10
  * The clients requirements must be met
  * Once the clients requirements are met the call centre would like
    to reach for an ROI of 1.20
  * If the clients ROI surpasses 3.0, then the call centre would like to
    aim for its ROI to be at least 1.30


### Who should call which segment?
Once the campaign has been called for a while it would be useful to find who should call which data segment to get the best results.  The details of the experiment are recorded in an experiment file called `acmeprinters_repair016_who_should_call_which_segment.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "Who should call which segment?"
category: "acme"
tags:
  - repair
  - sales
  - acmePrinters
dataset: "sql"
sql:
  driverName: "mssql"
  # The following is the connection string for the MS SQL Server database.
  # It is for a server at ip address: 127.0.0.1, port: 1433
  # The database is called: printrepair16
  # The user is: sa, with a password of: letmein
  dataSourceName: "Server=127.0.0.1;Port=1433;Database=printrepair16;UID=sa,PWD=letmein"
  query: "select name,segment,conversion,roi,value,ccCost,ccIncome from callerstats"
fields:
  - name
  - segment
  - conversion
  - roi
  - value
  - ccCost
  - ccIncome

# The following fields can be used in the rules
ruleFields:
  - name
  - segment
aggregators:
  # totalCCCost is the total call centre cost for a rule
  - name: "totalCCCost"
    kind: "sum"
    arg:  "ccCost"
  # totalCCIncome is the total call centre income for a rule
  - name: "totalCCIncome"
    kind: "sum"
    arg:  "ccIncome"
  # totalCCROI is the total call centre ROI (Return On Investment) for a rule
  - name: "totalCCROI"
    kind: "calc"
    arg:  "totalCCIncome / totalCCCost"
  - name: "totalCCProfit"
    kind: "calc"
    arg:  "totalCCIncome - totalCCCost"
  # totalValue is the total value of the contracts sold for a rule
  - name: "totalValue"
    kind: "sum"
    arg:  "value"
  - name: "meanConversion"
    kind: "mean"
    arg:  "conversion"
  # clientMeanROI is the average client ROI for a rule
  - name: "clientMeanROI"
    kind: "mean"
    arg: "roi"
# Below you see the goals specified by the call centre and the client
goals:
  - "totalCCROI >= 1.10"
  - "clientMeanROI >= 2"
  - "meanConversion > 0.25"
  - "totalCCROI >= 1.20"
  - "clientMeanROI > 3"
  - "totalCCROI >= 1.30"
sortOrder:
  # goalsScore is used to sort first as this is the most important
  # factor to be used when assessing the rules
  - aggregator: "goalsScore"
    direction:  "descending"
  - aggregator: "totalValue"
    direction:  "descending"
  - aggregator: "totalCCProfit"
    direction:  "descending"
# The experiment will be run every 40 minutes
when: "!hasRun || sinceLastRunMinutes > 40"
{{< /highlight >}}


After running this experiment a report is generated which starts as follows:

<img src="/img/acmeprinters_who_should_call_which_segment_top.png" class="outline" alt="screenshot of report">

The top of the report shows the best rule:
{{< highlight go >}}
in(name,"bob andrews","fred wilkins") || segment != "b"
{{< /highlight >}}

This rule is quite complicated at first sight.  To unpack it we could say that when picking who calls what segment that the following holds true:

  * Bob Andrews and Fred Wilkins can call any segment
  * Everyone else can call any segment except 'b'

Below the rule on the right you can see that it passes all the goals specified.  Below on the left you can see the results that this rule gives for the various aggregators specified.  The improvement column is the difference between the result for this rule and the `true()` rule.  The `true()` rule represents all the records being used for the aggregators.  This rule will always be at the end of the report as can be seen below:

<img src="/img/acmeprinters_who_should_call_which_segment_bottom.png" class="outline" style="margin-bottom: 2em;" alt="screenshot of report">

### Assessment of Report
The report shows that the best rule as defined by the experiment is:
{{< highlight go >}}
in(name,"bob andrews","fred wilkins") || segment != "b"
{{< /highlight >}}

For the client it achieves an ROI of 4.085, over twice their goal and a conversion of 55%, again over twice their goal.  For the call centre it achieves an ROI of 1.32 which is over target.  Using this rule both parties have their needs met and the client gets a healthy total value of contracts at: £86,748, only £3,300 less than the `true()` rule.

If only the `true()` rule was used i.e. the data wasn't filtered, then the call centre would have still met the clients goals, but would have missed out on its stretch goal of having an ROI of 1.30.

With the use of the best rule, the client gets a fantastic result and the call centre makes a healthy profit as well.  A healthy profit is particularly important for this company because they know that sometimes calling is unpredictable and they will often make a loss.  They need to minimize the losses where they can and make the most of profits when they are able.
