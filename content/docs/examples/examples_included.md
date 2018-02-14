---
title: "Examples Included"
description: "Rulehunter includes a number of example experiments"
weight: 50
draft: false
toc: false
bref: Rulehunter includes a number of example experiments
---

### Included Experiments

The [examples/](https://github.com/vlifesystems/rulehunter/blob/master/examples) directory of the repository contains a number of experiments, in [examples/experiments/](https://github.com/vlifesystems/rulehunter/blob/master/examples/experiments), to demonstrate how Rulehunter can be used:

<dl class="files">
  <dt>acmeprinters_repair016_who_should_call_which_segment.yaml</dt>
  <dd>A call centre is representing a client that wants to offer a repair contract to customers who have bought printers from them in the past. The call centre needs to balance its need to make a profit with the needs of their client.  This is used in a <a href="/docs/examples/call_centre_printer_repairs/">worked example</a>.</dd>

  <dt>bank_subscribe.yaml</dt>
  <dd>A Portuguese bank's telephone campaign to encourage customers to subscribe to a term deposit.  The bank wants to reduce its calls and improve the rate at which customers subscribe to a term deposit. This is used in a <a href="/docs/examples/bank_subscribe_term_deposit/">worked example</a>.</dd>

  <dt>breast_cancer_wisconsin_benign_high.yaml</dt>
  <dt>breast_cancer_wisconsin_malignant_high.yaml</dt>
  <dd>A group of doctors want to find out what indicates that a patient is likely to have breast cancer. They want to reduce the chance that a patient with breast cancer is miss diagnosed and increase the speed with which letters are sent out for patients to have further investigation.  These are used in a <a href="/docs/examples/breast_cancer_diagnosis/">worked example</a>.</dd>

  <dt>breast_cancer_wisconsin_malignant.yaml</dt>
  <dd>This experiment is focused purely on determening what is most like to indicate malignant breast tumours.</dd>

  <dt>breast_cancer_wisconsin_malignant_filtered.yaml</dt>
  <dd>In this experiment the results of the experiments: <code>breast_cancer_wisconsin_benign_high.yaml</code> and <code>breast_cancer_wisconsin_malignant_high.yaml</code>, are used to filter the dataset before running another experiment.</dd>

  <dt>iris-setosa.yaml</dt>
  <dt>iris-versicolor.yaml</dt>
  <dt>iris-virginica.yaml</dt>
  <dd>These experiments are used to determine if an iris plant is one of three types of iris: iris setosa, iris versicolor, iris virginica.


  <dt>steel_plate_faults_k_scratch.yaml</dt>
  <dd>This experiement uses the Matthews Correlation Coefficient in a binary classifier to detect <em>k scratches</em> in steel plate. This is used in a <a href="/docs/examples/steel_plate_fault/">worked example</a>.</dd>
</dl>
