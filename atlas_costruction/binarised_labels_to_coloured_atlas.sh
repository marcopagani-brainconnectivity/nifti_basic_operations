# this script merges binarised rois in a colored atlas


# name of the atlas (output)
atlas_name=atlas.nii.gz # edit this

# this creates a list.txt containing names of brain regions in 
# the first column and associated intensity values in the second column.
# The intesity is ascending and depends on alphabetical sorting. 

ls *.nii.gz > deleteme.txt
a=`ls *nii.gz | wc -l`
seq 1 $a > deleteme1.txt

paste deleteme.txt deleteme1.txt > list.txt

# this sums brain regions to obtain the atlas
while read line; do

		label=`echo "$line" | awk '{print $1}'`
		number=`echo "$line" | awk '{print $2}'`

		echo "$label" "$number"

		ImageMath 3 \
			${label%.nii.gz}_coloured.nii.gz \
			m $label \
			$number
done < list.txt

# this creates the first label
empty=$(ls *_coloured.nii.gz | sort -n | head -1)

ImageMath 3 \
	$atlas_name \
	m $empty \
	0

# this is for the remainging labels
for label in *_coloured.nii.gz ; do

	echo $label

	ImageMath 3 \
		$atlas_name \
		addtozero $atlas_name \
		$label
done

rm *_coloured.nii.gz
rm deleteme*txt
