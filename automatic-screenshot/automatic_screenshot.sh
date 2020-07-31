#!/bin/sh
# Author: ines.simicic@gmail.com
# Version 1.0 @ 2013-09-21
# half automated precise screen capture from any window - user is needed to prepare material to capture


# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

usage() #little manual
{
cat << EOF
Usage: $0 [ options ]

This script takes half-automatic screenshots - you still need to setup which screen content you want to capture at any given moment.
Is saves screenshots to active directory. It uses GraphicsMagick as screenshot tool (gm import).

If you use any option, argument is mandatory. Arguments cannot start with -
Initial setup is one fullscreen capture numerated as 001.png

OPTIONS:
  -h	
		Show this message
  -w <wid>
		Window ID, get it with xwininfo, default: whole screen
  -c <width>x<height>{+-}<x>{+-}<y>{%}
		Preferred size and location of the cropped image, default: full screen
		(geometry from GraphicsMagick)
  -a <alpha>
		Start for iteration, default: 1
  -o <omega>
		End for iteration, default: <alpha> value
  -p <pause>
		Number of seconds to wait before new screenshot, default: 6
		Can be break by ENTER.
  -d <digits>
		Number of digits for sufix, default: 3
  -q <num>     
		Quality in percent, default: 100
  -e <filetype>
		File extension, default: png
  -f <filename>
		Filename base, default: <none>
EOF
}

usageshort() #short reminder
{
cat << EOF
Usage: $0 [wcaopdqef] (arguments are mandatory if option is used)
windowId; crop geometry; from-alpha; to-omega; pause; digits; quality; filetype; filename base
EOF
}

# test if arguments are correct, and not some option filled instead an argument
# drawback - arguments cannot start with - char, but that feature isn't needed
test() 
{
if [[ $1 == -* ]]
then
  echo "Arguments are mandatory." 
  usageshort
  exit 1
fi
}

# Initialize variables to deafult values
wid="root" #window id, with xwinfo
crop="none" #graphicsMagick argument for crop option
alpha=1 #range start
omega=1 #range end
pause=6 #seconds for pause
dig=3 #number of digits in sufix
qual=100 #quality of image
ext="png" #default extension of file
file="" #filename base
default=1;

# Fill variables according to function call
while getopts "hw:c:a:o::p:d:q:e:f:" opt
do
  test $OPTARG
  case $opt in
    h) usage; exit 0 ;;
    w) wid=$OPTARG; default=0 ;;
    c) crop=$OPTARG; default=0 ;;
    a) alpha=$OPTARG; omega=$OPTARG; default=0 ;; #default is that they're equal
    o) omega=$OPTARG; default=0 ;;
    p) pause=$OPTARG; default=0 ;;
    d) dig=$OPTARG; default=0 ;;
    q) qual=$OPTARG; defatul=0 ;;
    e) ext=$OPTARG; default=0 ;;
    f) file=$OPTARG; default=0 ;;
   \?) echo >&2; usageshort; exit 1 ;;
    :) usageshort; exit 1 ;;
  esac		
done

# clear list of arguments
shift $((OPTIND-1))

[ "$1" = "--" ] && shift

# number of arguments left on command line, should be 0 if everything is ok
args=$#
 
if [[ $args -ne 0 ]]
then
  echo "Error: wrong (number of?) parameters."; usageshort
  exit 1
fi


# test output
# echo "crop: $crop range: $alpha - $omega dig: $dig quality: $qual ext: $ext file: $file Leftovers: $@"

# iterate from alpha to omega, with delay of $pause seconds, and optional user pause

id=$alpha

#if every option is default one, shorten first wait
if [[ $default == 1 ]]
then
  pause=3
fi

#Let's get this party started
read -t $(($pause*3)) -p "Little delay for preparation ($(($pause*3))s, hit ENTER when ready.)"

while [ $id -le $omega ]
do
  filename=$file$(printf "%0*d" $dig $id)"."$ext

  #check if crop format is set
  if [[ $crop == "none" ]]
  then 
    gm import -window $wid -quality $qual $filename
  else 
    gm import -window $wid -crop $crop -quality $qual $filename
  fi

  echo $filename "is saved"
  if [[ $id -eq $omega ]]
  then
    echo -e "\nThank you, that would be all."
    break
  fi

  #to give automatic pause for setup new screen to capture
  echo -e "\nPlease prepare screen [$(printf "% *d" $dig $(($id+1)))], you got $pause seconds till snapshot."
  read -t $pause -p "For longer pause - hit p; for stop - hit q; for continue now - hit ENTER: " response; echo

  #to give user pause
  if [[ $response == "p" || $response == "P" ]]
  then
    read -p "Paused, hit ENTER to continue. "; echo
  else 
    if [[ $response == "q" || $response == "Q" ]]
    then
      echo "Aborted. Last used id: $id"
      exit 0;
    fi
  fi

  # increase counter
  id=$[id+1]

done

# End of file