---
title: "Steel Plate Fault"
description: "Quality control detecting faults in steel plate"
weight: 70
draft: false
toc: true
bref: "An example of quality control detecting a fault in steel plate"
---

### Outline

A quality control office wants to use machine learning to improve its detection of k scratch faults.

#### Requirements

  * The detection of the _k scratch_ faults must be as accurate as possible

#### The Dataset
This example uses a dataset provided by [Semeion](http://www.semeion.it), Research Center of Sciences of Communication, Via Sersale 117, 00128, Rome, Italy.  It is hosted at:<br />
<div style="margin-left: 2em; font-family: monospace;">
  [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml).<br />
  Irvine, CA: University of California, School of Information and
  Computer Science. <br />
  [Steel Plates Faults Data Set ](https://archive.ics.uci.edu/ml/datasets/Steel+Plates+Faults)<br />
</div>

### What indicates a _k scratch_ fault?
Once enough data has been carefully collected, Rulehunter is set to work.  The details of the experiment are recorded in an experiment file called `steel_plate_faults_k_scratch.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "What indicates a steel plate k scratch fault?"
category: "engineering"
tags:
  - steel
train:
  dataset:
    csv:
      filename: "csv/steel_plate_faults.tsv"
      hasHeader: false
      separator: "\t"
    fields:
      - X_Minimum
      - X_Maximum
      - Y_Minimum
      - Y_Maximum
      - Pixels_Areas
      - X_Perimeter
      - Y_Perimeter
      - Sum_of_Luminosity
      - Minimum_of_Luminosity
      - Maximum_of_Luminosity
      - Length_of_Conveyer
      - TypeOfSteel_A300
      - TypeOfSteel_A400
      - Steel_Plate_Thickness
      - Edges_Index
      - Empty_Index
      - Square_Index
      - Outside_X_Index
      - Edges_X_Index
      - Edges_Y_Index
      - Outside_Global_Index
      - LogOfAreas
      - Log_X_Index
      - Log_Y_Index
      - Orientation_Index
      - Luminosity_Index
      - SigmoidOfAreas
      - Pastry
      - Z_Scratch
      - K_Scratch
      - Stains
      - Dirtiness
      - Bumps
      - Other_Faults
  when: "!hasRun"
ruleGeneration:
  fields:
    - X_Minimum
    - X_Maximum
    - Y_Minimum
    - Y_Maximum
    - Pixels_Areas
    - X_Perimeter
    - Y_Perimeter
    - Sum_of_Luminosity
    - Minimum_of_Luminosity
    - Maximum_of_Luminosity
    - Length_of_Conveyer
    - TypeOfSteel_A300
    - TypeOfSteel_A400
    - Steel_Plate_Thickness
    - Edges_Index
    - Empty_Index
    - Square_Index
    - Outside_X_Index
    - Edges_X_Index
    - Edges_Y_Index
    - Outside_Global_Index
    - LogOfAreas
    - Log_X_Index
    - Log_Y_Index
    - Orientation_Index
    - Luminosity_Index
    - SigmoidOfAreas
  # Allow arithmetic in rules to help improve detection
  arithmetic: true
aggregators:
  # The Matthews Correlation Coefficient is ideal for this sort of
  # binary classification
  - name: "mccHasKScratch"
    kind: "mcc"
    arg: "K_Scratch == 1"
  - name: "recallHasKScratch"
    kind: "recall"
    arg: "K_Scratch == 1"
  - name: "precisionHasKScratch"
    kind: "precision"
    arg: "K_Scratch == 1"
sortOrder:
  - aggregator: "mccHasKScratch"
    direction: "descending"
{{< /highlight >}}


#### Assessment of Report
After running the experiment a report is generated which finds the following rule:

<div class="rule">
Log_X_Index + Square_Index >= 2.46 && Outside_X_Index * TypeOfSteel_A400 >= 0.044
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
      <td>mccHasKScratch</td>
      <td>0</td>
      <td>0.8822</td>
      <td>0.8822</td>
    </tr>

    <tr>
      <td>numMatches</td>
      <td>1941</td>
      <td>333</td>
      <td>-1608</td>
    </tr>

    <tr>
      <td>percentMatches</td>
      <td>100</td>
      <td>17.16</td>
      <td>-82.84</td>
    </tr>

    <tr>
      <td>precisionHasKScratch</td>
      <td>0.2014</td>
      <td>0.979</td>
      <td>0.7776</td>
    </tr>

    <tr>
      <td>recallHasKScratch</td>
      <td>1</td>
      <td>0.8338</td>
      <td>-0.1662</td>
    </tr>

  </table>
</div>


The top of the report shows the best rule:
{{< highlight go >}}
Log_X_Index + Square_Index >= 2.46 && Outside_X_Index * TypeOfSteel_A400 >= 0.044
{{< /highlight >}}

With this rule 83% (_recallHasKScratch_) of _k scratches_ are detected and if the rule says that a _k scratch_ is present, then it is 98% (_precisionHasKScratch_) accurate.
