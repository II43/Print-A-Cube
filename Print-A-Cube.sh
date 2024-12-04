#! /bin/bash
#####################################
# PARAMETERS DEFINITION
NEW_SIZE="242x242"
declare -a positions NEW_POSITIONS=(
    "+302+86"
    "+302+334"
    "+302+580"
    "+302+826"
    "+56+334"
    "+550+334"
)
#####################################
# Input
if [ $# -eq 0 ]
then
    echo "Error: No arguments supplied! You must provide an image file to process!"
    exit 1
fi
INPUTFILE=$1
echo "PRINT-A-CUBE" 
echo "Processing file:" $INPUTFILE
echo "┏━━━━━"
if [ ! -f $INPUTFILE ]
then
    echo "┣ Error: Provided image file doesn't exist!"
    echo "┻"
    exit 1    
fi
echo "┣ output cube side width x height:" $NEW_SIZE
mkdir tmp

cp cube_template.png tmp/output.png

for pos in "${NEW_POSITIONS[@]}"
do
   echo "┣ pasting overlay image to position:" $pos
   convert tmp/output.png \( $INPUTFILE -resize $NEW_SIZE \) -gravity NorthWest -geometry $pos -composite tmp/output.png
done

echo "┣ converting to a(x)-$OUTPUTFILE"
OUTPUTFILE="cube-"
OUTPUTFILE+=$(basename $INPUTFILE | cut -d. -f1)
OUTPUTFILE+=".pdf"
convert tmp/output.png -page A4 a4-$OUTPUTFILE
convert -quality 100% tmp/output.png -resize 3507x4959 -extent 3507x4959 a3-$OUTPUTFILE

echo "┣ cleaning up"
rm -r tmp
echo "┻" 