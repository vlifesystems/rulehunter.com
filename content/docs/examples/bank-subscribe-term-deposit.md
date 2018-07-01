### Outline

A Portuguese bank wants to encourage customers to subscribe to a term deposit.

#### Requirements

  * The bank wants to reduce the number of customers it contacts.  Therefore it wants to ensure that those it does contact are most likely to subscribe to a term deposit.

#### The Dataset
This example uses a dataset related to a direct marketing campaign run by a Portuguese Bank.  The dataset is described by [Moro et al., 2014] S. Moro, P. Cortez and P. Rita. A Data-Driven Approach to Predict the Success of Bank Telemarketing. Decision Support Systems, Elsevier, 62:22-31, June 2014. It is hosted at:<br />
<div style="margin-left: 2em; font-family: monospace;">
  [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml).<br />
  Irvine, CA: University of California, School of Information and
  Computer Science. <br />
  [Bank Marketing Data Set ](https://archive.ics.uci.edu/ml/datasets/bank+marketing)
</div>

### Will customer subscribe to a bank term deposit?
The campaign is run for a while to collect enough data.  The details of the experiment are recorded in an experiment file called `bank_subscribe.yaml` which is located in the `experimentsDir` of `config.yaml`:

``` yaml
title: "Will customer subscribe to a bank term deposit?"
category: "bank"
tags:
  - business
train:
  dataset:
    csv:
      filename: "csv/bank.csv"
      hasHeader: true
      separator: ";"
    fields:
      - age
      - job
      - marital
      - education
      - default
      - balance
      - housing
      - loan
      - contact
      - day
      - month
      - duration
      - campaign
      - pdays
      - previous
      - poutcome
      - y
  when: "!hasRun || sinceLastRunMinutes > 40"
ruleGeneration:
  fields:
    - age
    - job
    - marital
    - education
    - default
    - balance
    - housing
    - loan
    - contact
    - day
    - month
    - campaign
    - pdays
    - previous
    - poutcome
  combinationLength: 3
aggregators:
  - name: "mccSubscribe"
    kind: "mcc"
    arg: "y == \"yes\""
  - name: "numSubscribe"
    kind: "count"
    arg: "y == \"yes\""
  - name: "recallSuccess"
    kind: "recall"
    arg: "y == \"yes\""
  - name: "precisionSuccess"
    kind: "precision"
    arg: "y == \"yes\""
sortOrder:
  # The Matthews Correlation Coefficient is ideal for this sort of
  # binary classification
  - aggregator: "mccSubscribe"
    direction: "descending"
```


#### Assessment of Report
After running the experiment a report is generated which finds the following rule:

``` go
in(month,"dec","mar","oct","sep") || poutcome == "success"
```

<table class="table table-bordered aggregators">
  <tr>
    <th>Aggregator</th>
    <th>Original Value</th>
    <th>Rule Value</th>
    <th>Change</th>
  </tr>

  <tr>
    <td>goalsScore</td>
    <td>0</td>
    <td>0</td>
    <td>0</td>
  </tr>

  <tr>
    <td>mccSubscribe</td>
    <td>0</td>
    <td>0.3444</td>
    <td>0.3444</td>
  </tr>

  <tr>
    <td>numMatches</td>
    <td>45211</td>
    <td>3145</td>
    <td>-42066</td>
  </tr>

  <tr>
    <td>numSubscribe</td>
    <td>5289</td>
    <td>1641</td>
    <td>-3648</td>
  </tr>

  <tr>
    <td>percentMatches</td>
    <td>100</td>
    <td>6.96</td>
    <td>-93.04</td>
  </tr>

  <tr>
    <td>precisionSuccess</td>
    <td>0.117</td>
    <td>0.5218</td>
    <td>0.4048</td>
  </tr>

  <tr>
    <td>recallSuccess</td>
    <td>1</td>
    <td>0.3103</td>
    <td>-0.6897</td>
  </tr>
</table>


The top of the report shows the best rule:
``` go
in(month,"dec","mar","oct","sep") || poutcome == "success"
```

The bank can now refine its campaign so that the following holds true:

  * Customers are best contacted in the months: _Dec_, _Mar_, _Oct_ or _Sep_
  * Customers who have previously subscribed can be contacted anytime

With this rule 31% (_recallSuccess_) of those customers contacted subscribe.  If the rule says that a customer should be contacted, then it is 52% (_precisionSuccess_) accurate, which is an improvement of 40 percentage points over not using a rule to filter customers.
