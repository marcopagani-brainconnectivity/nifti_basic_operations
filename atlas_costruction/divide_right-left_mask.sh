mask_left=$1
mask_right=$2

PARAMETERS=$#

if [ $PARAMETERS -lt 1  ]
then 
echo
echo " This script divide a bilateral label into left and right labels, "
echo " given two global binary masks "
echo
echo " Run this script in the folder that contains roi masks to be divided"
echo
echo " divide_right-left_mask.sh path/left_mask.nii.gz path/right_mask.nii.gz"
echo
echo
echo " Script written by Marco Pagani, Sept 2014"
exit
fi

for mask in *.nii.gz; do
ImageMath 3 ${mask%_bilateral.nii.gz}_sx.nii.gz m $mask $mask_left
mv ${mask%.nii.gz}_sx.nii.gz left_masks
ImageMath 3 ${mask%_bilateral.nii.gz}_dx.nii.gz m $mask $mask_right
mv ${mask%.nii.gz}_dx.nii.gz right_masks

done

exit
