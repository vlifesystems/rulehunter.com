---
title: "A Call Centre: Printer Repairs"
description: "A call centre selling printer repair contracts for its client"
weight: 70
draft: false
toc: true
bref: "An example of a call centre trying to balance its needs with those of their client"
---

### Outline

A call centre is representing a client that wants to offer a repair contract to customers who have bought printers from them in the past.  The call centre needs to balance its need to make a profit with the needs of their client.

#### The client's requirements

  * The ROI (Return On Investment) must be at least 15.0
  * At least 25% of contacts must result in a repair contract
  * They would like the total value of contracts to be as high as possible

#### The call centre's requirements

  * The ROI for the call centre needs to be at least 1.10
  * The clients requirements must be met
  * Once the clients requirements are met the call centre would like
    to reach for an ROI of 1.30

#### The call centre costs
The call centre has used the following factors to calculate their calling cost:

 * £0.04/min phone call cost
 * £10/hr caller cost
 * £10/hr overheads

This gives a cost to the call centre of £0.0062/second of calling:

    (0.04/60) + (10/60/60) + (10/60/60) = 0.0062

### Who should call which segment?
Once the campaign has been called for a while it would be useful to find who should call which data segment to get the best results.  The details of the experiment are recorded in an experiment file called `acmeprinters_repair016_who_should_call_which_segment.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "Who should call which segment?"
category: "acme"
tags:
  - repair
  - sales
  - printers
trainDataset:
  csv:
    filename: "csv/printer_repairs_callerstats.csv"
    hasHeader: true
    separator: ","
fields:
  - name
  - segment
  - conversion
  - callTime
  - numContacts
  - value
ruleGeneration:
  fields:
    - name
    - segment
aggregators:
  - name: "totalContacts"
    kind: "sum"
    arg: "numContacts"
  - name: "totalClientValue"
    kind: "sum"
    arg: "value"
    # 5% commission on all repair contracts
  - name: "totalClientCommission"
    kind: "calc"
    arg: "totalClientValue * 0.05"
    # £2 charge per contact
  - name: "totalClientContactCharge"
    kind: "calc"
    arg: "totalContacts * 2"
  - name: "totalClientCharge"
    kind: "calc"
    arg: "totalClientCommission + totalClientContactCharge"
  - name: "totalClientROI"
    kind: "calc"
    arg: "roundto(totalClientValue / (totalClientCharge + pow(0,totalClientCharge)), 2)"
  - name: "totalCallCentreCost"
    kind: "sum"
    # £0.04/min call cost, plus £10/hr caller cost, plus £10/hr overheads
    # Equal: (0.04/60) + (10/60/60) + (10/60/60) = 0.0062
    arg: "callTime * 0.0062"
  - name: "totalCallCentreProfit"
    kind: "calc"
    arg: "totalClientCharge - totalCallCentreCost"
  - name: "meanConversion"
    kind: "mean"
    arg: "conversion"
  - name: "totalCallCentreROI"
    kind: "calc"
    arg: "roundto(totalClientCharge / (totalCallCentreCost + pow(0,totalCallCentreCost)), 2)"
goals:
  - "totalCallCentreROI >= 1.10"
  - "totalClientROI >= 15"
  - "meanConversion > 0.25"
  - "totalCallCentreROI >= 1.30"
sortOrder:
  - aggregator: "goalsScore"
    direction: "descending"
  - aggregator: "totalClientValue"
    direction: "descending"
  - aggregator: "totalCallCentreROI"
    direction: "descending"
  - aggregator: "meanConversion"
    direction: "descending"
# The experiment should be run every 40 minutes
when: "!hasRun || sinceLastRunMinutes > 40"
{{< /highlight >}}


#### Assessment of Report
After running the experiment a report is generated which finds the following rule:

<div class="rule">
(in(name,&#34;Fred Wilkins&#34;,&#34;Martha Stuart&#34;,&#34;Rebecca Davies&#34;) &amp;&amp; in(segment,&#34;a&#34;,&#34;c&#34;,&#34;f&#34;,&#34;g&#34;)) || (in(name,&#34;Fred Wilkins&#34;,&#34;Mary Harris&#34;) || segment == &#34;g&#34;)
</div>
<div class="aggregators">
  <table>
    <tr>
      <th>Aggregator</th>
      <th>Original Value</th>
      <th>Rule Value</th>
      <th>Change</th>
    </tr>

    <tr>
      <td>goalsScore</td>
      <td>0</td>
      <td>4</td>
      <td>4</td>
    </tr>

    <tr>
      <td>meanConversion</td>
      <td>0.1584</td>
      <td>0.3028</td>
      <td>0.1444</td>
    </tr>

    <tr>
      <td>numMatches</td>
      <td>49</td>
      <td>25</td>
      <td>-24</td>
    </tr>

    <tr>
      <td>percentMatches</td>
      <td>100</td>
      <td>51.02</td>
      <td>-48.98</td>
    </tr>

    <tr>
      <td>totalCallCentreCost</td>
      <td>90267.20120000002</td>
      <td>38595.396799999995</td>
      <td>-51671.80440000002</td>
    </tr>

    <tr>
      <td>totalCallCentreProfit</td>
      <td>-31954.10120000002</td>
      <td>14669.653200000008</td>
      <td>46623.75440000004</td>
    </tr>

    <tr>
      <td>totalCallCentreROI</td>
      <td>0.65</td>
      <td>1.38</td>
      <td>0.73</td>
    </tr>

    <tr>
      <td>totalClientCharge</td>
      <td>58313.100000000006</td>
      <td>53265.05</td>
      <td>-5048.050000000002</td>
    </tr>

    <tr>
      <td>totalClientCommission</td>
      <td>43133.100000000006</td>
      <td>43105.05</td>
      <td>-28.050000000003</td>
    </tr>

    <tr>
      <td>totalClientContactCharge</td>
      <td>15180</td>
      <td>10160</td>
      <td>-5020</td>
    </tr>

    <tr>
      <td>totalClientROI</td>
      <td>14.79</td>
      <td>16.19</td>
      <td>1.4</td>
    </tr>

    <tr>
      <td>totalClientValue</td>
      <td>862662</td>
      <td>862101</td>
      <td>-561</td>
    </tr>

    <tr>
      <td>totalContacts</td>
      <td>7590</td>
      <td>5080</td>
      <td>-2510</td>
    </tr>

  </table>
</div>

<div class="goals">
  <table>
    <tr>
      <th>Goal</th><th>Original Value</th><th>Rule Value</th>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.10</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalClientROI &gt;= 15</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>meanConversion &gt; 0.25</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.30</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

  </table>
</div>

The top of the report shows the best rule:
{{< highlight go >}}
(in(name,&#34;Fred Wilkins&#34;,&#34;Martha Stuart&#34;,&#34;Rebecca Davies&#34;) &amp;&amp; in(segment,&#34;a&#34;,&#34;c&#34;,&#34;f&#34;,&#34;g&#34;)) ||
(in(name,&#34;Fred Wilkins&#34;,&#34;Mary Harris&#34;) || segment == &#34;g&#34;)
{{< /highlight >}}

This rule is quite complicated at first sight.  To unpack it we could say that when picking who calls what segment that the following holds true:

  * _Fred Wilkins_, _Martha Stuart_ and _Rebecca Davies_ can call segments: _a_, _c_, _f_ and _g_
  * _Fred Wilkins_ and _Mary Harris_ can call any segment
  * Anyone can call segment: _g_

Below the aggregators table you can see that the rule passes all the goals, unlike when no rule was used.  With the rule the client has an ROI of 16.19, this is 1.4 more than without the rule and 1.19 above target.  Again with the rule the client has a conversion of 0.3, this is 0.14 percentage points more than without the rule and 0.05 above the target.  Finally the call centre, with the rule, has an ROI of 1.38, this is 0.73 more than without the rule and 0.08 above the stetch target.  This final figure is probably the most important as without the rule the call centre was making a loss and now it is making a profit.  The client is also happy as they are above target on both of their main goals.


### When to call each segment?

Once the campaign has been called for a while it would be useful to find when to call each segment to get the best results.  The details of the experiment are recorded in an experiment file called `acmeprinters_repair016_when_to_call_each_segment.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "When to call each segment?"
category: "acme"
tags:
  - repair
  - sales
  - printers
trainDataset:
  csv:
    filename: "csv/printer_repairs_callstats.csv"
    hasHeader: true
    separator: ","
fields:
  - quarter
  - segment
  - callTime
  - isComplete
  - isContact
  - value
ruleGeneration:
  fields:
    - quarter
    - segment
aggregators:
  - name: "totalContacts"
    kind: "count"
    arg: "isContact"
  - name: "totalClientValue"
    kind: "sum"
    arg: "value"
    # 5% commission on all repair contracts
  - name: "totalClientCommission"
    kind: "calc"
    arg: "totalClientValue * 0.05"
    # £2 charge per contact
  - name: "totalClientContactCharge"
    kind: "calc"
    arg: "totalContacts * 2"
  - name: "totalClientCharge"
    kind: "calc"
    arg: "totalClientCommission + totalClientContactCharge"
  - name: "totalClientROI"
    kind: "calc"
    arg: "roundto(totalClientValue / (totalClientCharge + pow(0,totalClientCharge)), 2)"
  - name: "numSignups"
    kind: "count"
    arg: "value > 0"
  - name: "totalCallCentreCost"
    kind: "sum"
    # £0.04/min call cost, plus £10/hr caller cost, plus £10/hr overheads
    # Equal: (0.04/60) + (10/60/60) + (10/60/60) = 0.0062
    arg: "callTime * 0.0062"
  - name: "totalCallCentreProfit"
    kind: "calc"
    arg: "totalClientCharge - totalCallCentreCost"
  - name: "conversion"
    kind: "calc"
    arg: "roundto(numSignups / (totalContacts + pow(0,totalContacts)), 2)"
  - name: "totalCallCentreROI"
    kind: "calc"
    arg: "roundto(totalClientCharge / (totalCallCentreCost + pow(0,totalCallCentreCost)), 2)"
goals:
  - "totalCallCentreROI >= 1.10"
  - "totalClientROI >= 15"
  - "conversion > 0.25"
  - "totalCallCentreROI >= 1.30"
sortOrder:
  - aggregator: "goalsScore"
    direction: "descending"
  - aggregator: "totalClientValue"
    direction: "descending"
  - aggregator: "totalCallCentreROI"
    direction: "descending"
  - aggregator: "conversion"
    direction: "descending"
when: "!hasRun || sinceLastRunMinutes > 40"
{{< /highlight >}}

#### Assessment of Report
After running the experiment a report is generated which finds the following rule:

<div class="rule">
(in(segment,"a","d","f","g") && quarter <= 2) || (in(segment,"b","c","e") && quarter >= 3)
</div>

<div class="aggregators">
  <table>
    <tr>
      <th>Aggregator</th>
      <th>Original Value</th>
      <th>Rule Value</th>
      <th>Change</th>
    </tr>

    <tr>
      <td>conversion</td>
      <td>0.16</td>
      <td>0.34</td>
      <td>0.18</td>
    </tr>

    <tr>
      <td>goalsScore</td>
      <td>0</td>
      <td>4</td>
      <td>4</td>
    </tr>

    <tr>
      <td>numMatches</td>
      <td>5000</td>
      <td>1250</td>
      <td>-3750</td>
    </tr>

    <tr>
      <td>numSignups</td>
      <td>180</td>
      <td>167</td>
      <td>-13</td>
    </tr>

    <tr>
      <td>percentMatches</td>
      <td>100</td>
      <td>25</td>
      <td>-75</td>
    </tr>

    <tr>
      <td>totalCallCentreCost</td>
      <td>18020.126400000016</td>
      <td>3452.327400000001</td>
      <td>-14567.799000000014</td>
    </tr>

    <tr>
      <td>totalCallCentreProfit</td>
      <td>-11260.176400000015</td>
      <td>1960.1225999999988</td>
      <td>13220.299000000014</td>
    </tr>

    <tr>
      <td>totalCallCentreROI</td>
      <td>0.38</td>
      <td>1.57</td>
      <td>1.19</td>
    </tr>

    <tr>
      <td>totalClientCharge</td>
      <td>6759.95</td>
      <td>5412.45</td>
      <td>-1347.5</td>
    </tr>

    <tr>
      <td>totalClientCommission</td>
      <td>4483.95</td>
      <td>4436.45</td>
      <td>-47.5</td>
    </tr>

    <tr>
      <td>totalClientContactCharge</td>
      <td>2276</td>
      <td>976</td>
      <td>-1300</td>
    </tr>

    <tr>
      <td>totalClientROI</td>
      <td>13.27</td>
      <td>16.39</td>
      <td>3.12</td>
    </tr>

    <tr>
      <td>totalClientValue</td>
      <td>89679</td>
      <td>88729</td>
      <td>-950</td>
    </tr>

    <tr>
      <td>totalContacts</td>
      <td>1138</td>
      <td>488</td>
      <td>-650</td>
    </tr>

  </table>
</div>


<div class="goals">
  <table>
    <tr>
      <th>Goal</th><th>Original Value</th><th>Rule Value</th>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.10</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalClientROI &gt;= 15</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>conversion &gt; 0.25</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.30</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

  </table>
</div>


The top of the report shows the best rule:
{{< highlight go >}}
(in(segment,"a","d","f","g") && quarter <= 2) ||
(in(segment,"b","c","e") && quarter >= 3)
{{< /highlight >}}

To put this rule in more human readable terms, we could say that when picking which segment to call in each quarter that the following holds true:

  * Segments: _a_, _d_, _f_ and _g_ can be called in quarter _2_ or before
  * Segments: _b_, _c_ and _e_ can be called in quarter _3_ or after

Below the aggregators table you can see that the rule passes all the goals, unlike when no rule was used.  With the rule the client has an ROI of 16.39, this is 3.12 more than without the rule and 1.39 above target.  Again with the rule the client has a conversion of 0.34, this is 0.18 percentage points more than without the rule and 0.09 above the target.  Finally the call centre, with the rule, has an ROI of 1.57, this is 1.19 more than without the rule and 0.27 above the stetch target.  This final figure is probably the most important as without the rule the call centre was making a loss and now it is making a profit.  The client is also happy as they are above target on both of their main goals.


### How many callbacks to make per segment?

Once the campaign has been called for a while it would be useful to find when to call each segment to get the best results.  The details of the experiment are recorded in an experiment file called `acmeprinters_repair016_how_many_callbacks_per_segment.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "How many callbacks to make per segment?"
category: "acme"
tags:
  - repair
  - sales
  - printers
trainDataset:
  csv:
    filename: "csv/printer_repairs_callbacks.csv"
    hasHeader: true
    separator: ","
fields:
  - callbacks
  - segment
  - callTime
  - isComplete
  - isContact
  - value
ruleGeneration:
  fields:
    - callbacks
    - segment
aggregators:
  - name: "totalContacts"
    kind: "count"
    arg: "isContact"
  - name: "totalClientValue"
    kind: "sum"
    arg: "value"
    # 5% commission on all repair contracts
  - name: "totalClientCommission"
    kind: "calc"
    arg: "totalClientValue * 0.05"
    # £2 charge per contact
  - name: "totalClientContactCharge"
    kind: "calc"
    arg: "totalContacts * 2"
  - name: "totalClientCharge"
    kind: "calc"
    arg: "totalClientCommission + totalClientContactCharge"
  - name: "totalClientROI"
    kind: "calc"
    arg: "roundto(totalClientValue / (totalClientCharge + pow(0,totalClientCharge)), 2)"
  - name: "numSignups"
    kind: "count"
    arg: "value > 0"
  - name: "totalCallCentreCost"
    kind: "sum"
    # £0.04/min call cost, plus £10/hr caller cost, plus £10/hr overheads
    # Equal: (0.04/60) + (10/60/60) + (10/60/60) = £0.0062/second
    arg: "callTime * 0.0062"
  - name: "totalCallCentreProfit"
    kind: "calc"
    arg: "totalClientCharge - totalCallCentreCost"
  - name: "conversion"
    kind: "calc"
    arg: "roundto(numSignups / (totalContacts + pow(0,totalContacts)), 2)"
  - name: "totalCallCentreROI"
    kind: "calc"
    arg: "roundto(totalClientCharge / (totalCallCentreCost + pow(0,totalCallCentreCost)), 2)"
goals:
  - "totalCallCentreROI >= 1.10"
  - "totalClientROI >= 15"
  - "conversion > 0.25"
  - "totalCallCentreROI >= 1.30"
sortOrder:
  - aggregator: "goalsScore"
    direction: "descending"
  - aggregator: "totalClientValue"
    direction: "descending"
  - aggregator: "totalCallCentreROI"
    direction: "descending"
  - aggregator: "conversion"
    direction: "descending"
rules:
  - "(callbacks <= 5  && in(segment,\"a\",\"d\",\"f\",\"g\")) || (callbacks <= 9 && in(segment,\"b\",\"c\",\"e\"))"
when: "!hasRun || sinceLastRunMinutes > 40"
{{< /highlight >}}

#### Assessment of Report
After running the experiment a report is generated which finds the following rule:

<div class="rule">
(callbacks <= 5 && in(segment,"a","d","f","g")) || (callbacks <= 9 && in(segment,"b","c","e"))
</div>

<div class="aggregators">
  <table>
    <tr>
      <th>Aggregator</th>
      <th>Original Value</th>
      <th>Rule Value</th>
      <th>Change</th>
    </tr>

    <tr>
      <td>conversion</td>
      <td>0.15</td>
      <td>0.33</td>
      <td>0.18</td>
    </tr>

    <tr>
      <td>goalsScore</td>
      <td>0</td>
      <td>4</td>
      <td>4</td>
    </tr>

    <tr>
      <td>numMatches</td>
      <td>5000</td>
      <td>1250</td>
      <td>-3750</td>
    </tr>

    <tr>
      <td>numSignups</td>
      <td>176</td>
      <td>164</td>
      <td>-12</td>
    </tr>

    <tr>
      <td>percentMatches</td>
      <td>100</td>
      <td>25</td>
      <td>-75</td>
    </tr>

    <tr>
      <td>totalCallCentreCost</td>
      <td>17822.00540000002</td>
      <td>3382.7014000000013</td>
      <td>-14439.304000000018</td>
    </tr>

    <tr>
      <td>totalCallCentreProfit</td>
      <td>-11059.355400000019</td>
      <td>2061.7485999999985</td>
      <td>13121.104000000018</td>
    </tr>

    <tr>
      <td>totalCallCentreROI</td>
      <td>0.38</td>
      <td>1.61</td>
      <td>1.23</td>
    </tr>

    <tr>
      <td>totalClientCharge</td>
      <td>6762.650000000001</td>
      <td>5444.45</td>
      <td>-1318.200000000001</td>
    </tr>

    <tr>
      <td>totalClientCommission</td>
      <td>4486.650000000001</td>
      <td>4446.45</td>
      <td>-40.200000000001</td>
    </tr>

    <tr>
      <td>totalClientContactCharge</td>
      <td>2276</td>
      <td>998</td>
      <td>-1278</td>
    </tr>

    <tr>
      <td>totalClientROI</td>
      <td>13.27</td>
      <td>16.33</td>
      <td>3.06</td>
    </tr>

    <tr>
      <td>totalClientValue</td>
      <td>89733</td>
      <td>88929</td>
      <td>-804</td>
    </tr>

    <tr>
      <td>totalContacts</td>
      <td>1138</td>
      <td>499</td>
      <td>-639</td>
    </tr>

  </table>
</div>

<div class="goals">
  <table>
    <tr>
      <th>Goal</th><th>Original Value</th><th>Rule Value</th>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.10</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalClientROI &gt;= 15</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>conversion &gt; 0.25</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

    <tr>
      <td>totalCallCentreROI &gt;= 1.30</td>
      <td class="goalPassed-false">
        false
      </td>
      <td class="goalPassed-true">
        true
      </td>
    </tr>

  </table>
</div>


The top of the report shows the best rule:
{{< highlight go >}}
(callbacks <= 5 && in(segment,"a","d","f","g")) ||
(callbacks <= 9 && in(segment,"b","c","e"))
{{< /highlight >}}

To put this rule in more human readable terms, we could say that when setting the maximum number of callbacks for each segment that the following holds true:

  * Segments: _a_, _d_, _f_ and _g_ should have the maximum number of callbacks set to _5_
  * Segments: _b_, _c_ and _e_ should have the maximum number of callbacks set to _9_

Below the aggregators table you can see that the rule passes all the goals, unlike when no rule was used.  With the rule the client has an ROI of 16.33, this is 3.06 more than without the rule and 1.33 above target.  Again with the rule the client has a conversion of 0.33, this is 0.08 percentage points more than without the rule and 0.054 above the target.  Finally the call centre, with the rule, has an ROI of 1.61, this is 1.23 more than without the rule and 0.31 above the stetch target.  This final figure is probably the most important as without the rule the call centre was making a loss and now it is making a profit.  The client is also happy as they are above target on both of their main goals.


### Conclusion

With the use of the three types of rule, the client gets a fantastic result and the call centre makes a healthy profit as well.  A healthy profit is particularly important for this company because they know that sometimes calling is unpredictable and they will often make a loss.  They need to minimize the losses where they can and make the most of profits when they are able.
