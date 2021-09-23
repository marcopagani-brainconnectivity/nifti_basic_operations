
# Use this script in the folder that contains the binarised ROIs
# that you want to merge in a single atlas colored with the values
# that are specified in in $values
#
# provide a text file $values, 
# where the first colum is the basename of the ROIs 
# (name without .nii.gz) and the second is the value. 
# For example:
#
# M1	1
# M2	3
# mammillary_bodies	3
# medial_septum	2
# .....

atlas_name=atlas_name.nii.gz
values=list_name.txt

while read line; do

	basename=`echo "$line" | awk '{print $1}'`
	mean=`echo "$line" | awk '{print $2}'`

	echo $basename

	ImageMath 3 \
		${basename}_colored.nii.gz \
		m ${basename}.nii.gz \
		$mean \

done < $values

# take the first ROI as a reference to create
# an initial empty atlas 
label1=$(ls *.nii.gz | sort -n | head -1)

ImageMath 3 \
	$atlas_name \
	m $label1 \
	0


# merge the labels in a single colored atlas
for img in *colored.nii.gz; do

	echo $img

	ImageMath 3 \
		$atlas_name \
		addtozero \
		$atlas_name \
		$img

	rm $img

done


