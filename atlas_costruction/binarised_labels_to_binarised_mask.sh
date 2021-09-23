#!/bin/bash

#example of roi name is amygdala.nii.gz

roi_name=$1

label1=$(ls *.nii.gz | sort -n | head -1)
echo $label1
ImageMath 3 $roi_name + $label1 $label1
echo $roi_name

for label2 in `ls *nii.gz` ; do

ImageMath 3 $roi_name + $roi_name $label2
echo $label2
done

ThresholdImage 3 $roi_name $roi_name 0.5 Inf
echo thresholded
