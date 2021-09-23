
# This script creates binary_ROI.nii.gz for each of the ROI 
# of a parcellated atlas (atlas.nii.gz).
# 
# To assign the filename to nifti files, provide a list.txt,
# where the first column is the ROI value in the parcellated atlas 
# and the second column is the name you wan to assign
#
# Usage: divide_labels.sh /path/atlas.nii.gz /path/label_list.txt
#
# example of label list is ambmc-c57bl6-label-cortex_v0.8.idx
# example of atlas is ambmc-c57bl6-label-cortex_v0.8_RAI_origin.nii.gz
#
#
# Script edited by Marco Pagani
# 14th Feb 2014
#

atlas=path/to/atlas.nii.gz
list_of_rois_and_numbers=path/to/list.txt

while read line; do

		label=`echo "$line" | awk '{print $1}'`
		number=`echo "$line" | awk '{print $2}'`
		
		echo "$label"
		echo "$number"
		
		ThresholdImage 3 $atlas del_${number}.nii.gz ${number}.nii.gz Inf
		next=`echo "$number + 1" | bc -l`
		ThresholdImage 3 $atlas del1_${number}.nii.gz $next.nii.gz Inf

		ImageMath 3 neg_del1_${number}.nii.gz Neg del1_${number}.nii.gz
		ImageMath 3 ${label}.nii.gz m del_${number}.nii.gz neg_del1_${number}.nii.gz

		rm del*
		rm neg*

done < $list_of_rois_and_numbers
