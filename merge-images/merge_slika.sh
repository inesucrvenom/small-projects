#!/bin/bash
#usage
#filename left-extension left-crop-% middle-extension right-extension right-crop-%
#npr
#2010-4-30.jpg bw-0 10 bw-2 bw-5 30
#it assume that all pics exists:
#2010-4-30.jpg
#2010-4-30-bw-0.jpg
#2010-4-30-bw-2.jpg
#2010-4-30-bw-5.jpg
#and that they are in SAME folder

args=$# #broj argumenata koji su stigli
MINPARAMS=7 #potreban broj parametara
#

i=1

if [ $args -lt $MINPARAMS ]
then
  echo
  echo "Usage: filename left-extension left-crop-cm middle-extension right-extension right-crop-cm, total-cm
  needed $MINPARAMS arguments!"
  exit 0
fi

# echo "$*"

file_tmp=$1		# koji fajl (osnovni dio)
left_ext=$2	# extenzija za lijevu sliku
total_cm=$7	# koliko je cm na ekranu
left_cm=$3	# postotak koliko ostaje s lijeve strane, od cm s lijeve strane
left_p=$[left_cm*100/total_cm]
mid_ext=$4	# ext za srednju sliku - ostaje sve osim L + D
right_ext=$5	# ext za desnu sliku 
right_cm=$6	# postotak od kojeg cm ide desno
right_p=$[(total_cm-right_cm)*100/total_cm]


file_L=`echo $1"-""$left_ext"".jpg"`
echo $file
file_w=`identify $file_L | sed -r 's/^(.*)JPEG (.*) (.*)\+.*/\2/' | sed -r 's/^(.*)x(.*)/\1/'`
# sirina slike
echo "$file_w"


left_s=$[file_w*left_p/100]
echo "left s = $left_s"

right_s=$[file_w*right_p/100]
echo "right s = $right_s"

mid_s=$[file_w-left_s-right_s]
echo "mid s = $mid_s"

#convert $file -crop "$left_s"x0+0+0 +repage lijevi.jpg
#file_L=`echo $file | sed -r 's/^(.*).jpg/\1-'/`"$left_ext"".jpg"
echo "$file_L"
convert $file_L -crop "$left_s"x0+0+0 +repage left.jpg

#file_M=`echo $file | sed -r 's/^(.*).jpg/\1-'/`"$mid_ext"".jpg"
file_M=`echo $1"-""$mid_ext"".jpg"`
echo "$file_M"
convert $file_M -crop "$mid_s"x0+"$left_s"+0 +repage mid.jpg

#file_R=`echo $file | sed -r 's/^(.*).jpg/\1-'/`"$right_ext"".jpg"
file_R=`echo $1"-""$right_ext"".jpg"`
echo "$file_R"
total=$[left_s+mid_s]
convert $file_R -crop "$right_s"x0+"$total"+0 +repage right.jpg

file_tmp=`echo "novo-"$file_tmp".jpg"`
echo $file_tmp

convert left.jpg mid.jpg right.jpg +append $file_tmp 
rm left.jpg mid.jpg right.jpg

exit 0