Welcome
=======

This site aims to be a comprehensive guide to Rulehunter.  It will cover how to get Rulehunter up & running, examples of use and how to make the most of it.

Overview of Rulehunter
----------------------
Rulehunter works through a series of experiments located in the `experimentsDir` specified in `config.yaml`.  It will process each experiment and output a report in html.  The html report is part of a website created in the `wwwDir` specified in `config.yaml`.

<img src="/img/front.png" class="img-responsive outline" alt="screenshot of front page">

To give users of the reports access to the website created you must serve it using the `wwwDir` as the root.  Then users will be able to navigate to a list of reports that have been generated.  These report titles can then be clicked on to read them.
