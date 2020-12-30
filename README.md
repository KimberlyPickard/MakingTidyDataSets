---
title: "README.md"
author: "Kimberly Pickard"
date: "12/29/2020"
output: html_document
---
#### Directory Structure and Scripts for Tidy Data exercise.


The **MakingTidyData** Repository consists of:

1. the script **Run_Analysis.R**
2. **README.md**
3. **CodeBook.md**
4. the result of our efforts: **NewTidySet.txt**

**Run_Analysis.R** checks to see if the original data files are 
residing in the local directory. If necessary the data files will be
script will download the files from directory:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script then merges and tidies this headerless data and writes it to the file
**NewTidySet.txt** which includes descriptive headers for each of its variables.