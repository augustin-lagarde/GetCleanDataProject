Getting And Cleaning Data - Course Project
=====================================================

## Introduction

Peer Assessments for Getting and Cleaning Data
This repo contains my course project to [Getting and Cleaning Data](https://www.coursera.org/course/getdata)'s coursera course.

This project aims at cleaning the dataset on "Human Activity Recognition Using Smartphones Dataset" provided by the following article :

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

For more informations on the data, look at the codebook.

## Contents

The repo contains :

1. a R script run_analysis.R that can download the raw dataset and provide a tidy data version nammed "tidydata.txt"
2. a Codebook describing the variables on the 'tidydata' dataset.
3. a Readme file.

## The analysis step

The code will perform the following operations :

* download the data, unzip them and load the different sets

* merge the different observations, labels and variables in one dataset and rename appropriately the variables

* subset the data to keep only the mean and standard deviation measurements

* Replace variable values labelled by their names and transform variable names into 'R standard' variable names.

* From this data set, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.