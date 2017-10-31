---
title: "Breast Cancer Diagnosis"
description: "Doctors want to improve diagnosis and speed-up follow-up letters for patients with suspected breast cancer"
weight: 60
draft: false
toc: true
bref: "An example of doctors wanting to improve diagnosis and speed-up the time it takes to send out follow-up letters for patients with suspected breast cancer"
---

### Outline

<em>The following is a hypothetical scenario used purely to demonstrate Rulehunter.  The results shouldn't be used in any real-world setting.</em>

A group of doctors want to find out what indicates that a patient is likely to have breast cancer.  They want to reduce the chance that a patient with breast cancer is miss diagnosed and increase the speed with which letters are sent out for patients to have further investigation.

#### The doctors' requirements

  * Patients who statistically definitely have a malignant breast tumour should automatically be sent a follow-up appointment letter.
  * Patients who statistically definitely have a benign breast tumour should automatically be sent an all clear letter.

#### The Dataset
This example uses a dataset created by University of Wisconsin and hosted at:<br />
<div style="margin-left: 2em; font-family: monospace;">
  [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml).<br />
  Irvine, CA: University of California, School of Information and
  Computer Science. <br />
  [Breast Cancer Wisconsin (Diagnostic) Data Set](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic))<br />
</div>


### Who should be sent a follow-up appointment letter?
The doctors created an experiment to find tumours that statistically are definitely malignant. The details of the experiment are recorded in an experiment file called `breast_cancer_wisconsin_malignant_high.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "Which breast tumours are malignant (very high confidence)?"
category: "medical"
tags:
  - breast cancer
  - cancer
  - wisconsin
dataset: "csv"

# The data they had been collated about breast cancer diagnosis in a CSV file
csv:
  filename: "csv/breast_cancer_wisconsin.csv"
  hasHeader: true
  separator: ","

# Field names representing the fields in the CSV file
fields:
  - id
  - diagnosis
  - radius_mean
  - texture_mean
  - perimeter_mean
  - area_mean
  - smoothness_mean
  - compactness_mean
  - concavity_mean
  - concave_points_mean
  - symmetry_mean
  - fractal_dimension_mean
  - radius_se
  - texture_se
  - perimeter_se
  - area_se
  - smoothness_se
  - compactness_se
  - concavity_se
  - concave_points_se
  - symmetry_se
  - fractal_dimension_se
  - radius_worst
  - texture_worst
  - perimeter_worst
  - area_worst
  - smoothness_worst
  - compactness_worst
  - concavity_worst
  - concave_points_worst
  - symmetry_worst
  - fractal_dimension_worst

ruleGeneration:
  # The following fields can be used in the rules
  fields:
    - radius_mean
    - texture_mean
    - perimeter_mean
    - area_mean
    - smoothness_mean
    - compactness_mean
    - concavity_mean
    - concave_points_mean
    - symmetry_mean
    - fractal_dimension_mean
    - radius_se
    - texture_se
    - perimeter_se
    - area_se
    - smoothness_se
    - compactness_se
    - concavity_se
    - concave_points_se
    - symmetry_se
    - fractal_dimension_se
    - radius_worst
    - texture_worst
    - perimeter_worst
    - area_worst
    - smoothness_worst
    - compactness_worst
    - concavity_worst
    - concave_points_worst
    - symmetry_worst
    - fractal_dimension_worst
  # Allow arithmetic rules to be generated
  arithmetic: true

aggregators:
  # Matthews correlation coefficient for correct 'malignant' diagnosis
  - name: "mccIsMalignant"
    kind: "mcc"
    arg: "diagnosis == \"M\""
  # Number of records where diagnosis is 'benign'
  - name: "numAreBenign"
    kind: "count"
    arg: "diagnosis == \"B\""
  # Number of records where diagnosis is 'malignant'
  - name: "numAreMalignant"
    kind: "count"
    arg: "diagnosis == \"M\""
  # Recall of 'malignant' diagnosis
  - name: "recallIsMalignant"
    kind: "recall"
    arg: "diagnosis == \"M\""
  # Precision of 'malignant' diagnosis
  - name: "precisionIsMalignant"
    kind: "precision"
    arg: "diagnosis == \"M\""

# From the requirements above
goals:
  #  The number of records with a 'benign' diagnosis must be 0
  - "numAreBenign == 0"
sortOrder:
  - aggregator: "goalsScore"
    direction: "descending"
  - aggregator: "numMatches"
    direction: "descending"
when: "!hasRun"
{{< /highlight >}}


#### Assessment of Report
After running the experiment a report is generated which starts as follows:

<img src="/img/breast_cancer_malignant_top.png" class="outline" alt="screenshot of report">

The top of the report shows the best rule:
{{< highlight go >}}
area_worst * symmetry_worst >= 308 || concave_points_worst * texture_worst >= 4.6
{{< /highlight >}}

The report shows that the tumours for 33% of the total records can be confidently assessed as malignant.  This represents 88% of the number of malignant tumours in the dataset.

Below the rule you can see the results that this rule gives for the various aggregators specified and below that you can can see that it passes all the goals specified.  The improvement column is the difference between the result for this rule and the `true()` rule.  The `true()` rule represents all the records being used for the aggregators.  This rule will always be at the end of the report as can be seen below:

<img src="/img/breast_cancer_malignant_bottom.png" class="outline" style="margin-bottom: 2em;" alt="screenshot of report">


### Who should be sent an all clear letter?
The doctors created an experiment to find tumours that statistically are definitely benign. The details of the experiment are recorded in an experiment file called `breast_cancer_wisconsin_benign_high.yaml` which is located in the `experimentsDir` of `config.yaml`:

{{< highlight yaml >}}
title: "Which breast tumours are benign (very high confidence)?"
category: "medical"
tags:
  - breast cancer
  - cancer
  - wisconsin
dataset: "csv"
csv:
  filename: "csv/breast_cancer_wisconsin.csv"
  hasHeader: true
  separator: ","
fields:
  - id
  - diagnosis
  - radius_mean
  - texture_mean
  - perimeter_mean
  - area_mean
  - smoothness_mean
  - compactness_mean
  - concavity_mean
  - concave_points_mean
  - symmetry_mean
  - fractal_dimension_mean
  - radius_se
  - texture_se
  - perimeter_se
  - area_se
  - smoothness_se
  - compactness_se
  - concavity_se
  - concave_points_se
  - symmetry_se
  - fractal_dimension_se
  - radius_worst
  - texture_worst
  - perimeter_worst
  - area_worst
  - smoothness_worst
  - compactness_worst
  - concavity_worst
  - concave_points_worst
  - symmetry_worst
  - fractal_dimension_worst
ruleGeneration:
  fields:
    - radius_mean
    - texture_mean
    - perimeter_mean
    - area_mean
    - smoothness_mean
    - compactness_mean
    - concavity_mean
    - concave_points_mean
    - symmetry_mean
    - fractal_dimension_mean
    - radius_se
    - texture_se
    - perimeter_se
    - area_se
    - smoothness_se
    - compactness_se
    - concavity_se
    - concave_points_se
    - symmetry_se
    - fractal_dimension_se
    - radius_worst
    - texture_worst
    - perimeter_worst
    - area_worst
    - smoothness_worst
    - compactness_worst
    - concavity_worst
    - concave_points_worst
    - symmetry_worst
    - fractal_dimension_worst
  arithmetic: true
aggregators:
  - name: "mccIsBenign"
    kind: "mcc"
    arg: "diagnosis == \"B\""
  - name: "numAreBenign"
    kind: "count"
    arg: "diagnosis == \"B\""
  - name: "numAreMalignant"
    kind: "count"
    arg: "diagnosis == \"M\""
  - name: "recallIsBenign"
    kind: "recall"
    arg: "diagnosis == \"B\""
  - name: "precisionIsBenign"
    kind: "precision"
    arg: "diagnosis == \"B\""
goals:
  - "numAreMalignant == 0"
sortOrder:
  - aggregator: "goalsScore"
    direction: "descending"
  - aggregator: "numMatches"
    direction: "descending"
when: "!hasRun"
{{< /highlight >}}

#### Assessment of Report
After running the experiment a report is generated with this best rule:

<img src="/img/breast_cancer_benign_top_rule.png" class="outline" alt="screenshot of report">

The top of the report shows the best rule:
{{< highlight go >}}
perimeter_worst * texture_worst <= 1908 || radius_worst * smoothness_mean <= 1.3
{{< /highlight >}}

The report shows that the tumours for 47% of the total records can be confidently assessed as benign.  This represents 75% of the number of benign tumours in the dataset.

### Conclusion
In the original dataset there were 569 records. If the two rules were used to send out automatic follow-up/all clear letters that would represent 453 records (187 malignant + 266 benign), leaving just 116 records (569 total - 453 automated) for the doctors to manually assess.

This is huge improvement for patients.  The majority of patients would get a follow-up letter straight away to let them know that either their tumour is benign or that they need to book a follow-up appointment and could potentially begin treatment earlier.

This would also represent a significant improvement for the doctors who now only need to manually assess 20% of the records (116 manual / 569 total).  This represents a big time saving for the doctors, freeing them up so that they can do more to help patients.

