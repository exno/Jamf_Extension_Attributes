#!/bin/bash
############################################

## Functions ###############################
function searchYear(){
	local i=0;
	for a in "${yearoptions[@]}"; do
		if [ "$a" = "$yearmarker" ]; then
            yearval="$i"
            return
        else
            ((i++))
        fi
	done
}
function searchWeek(){
	local i=0;
	for a in "${weekoptions[@]}"; do
		if [ "$a" = "$weekmarker" ]; then
            weekval="$i"
            return
        else
            ((i++))
        fi
	done
}

## Variables ###############################



serial=$( echo "$SerialNumber" | tr '[:upper:]' '[:lower:]')
yearmarker=$(echo "$serial" | cut -c4 | tr '[:upper:]' '[:lower:]')
weekmarker=$(echo "$serial" | cut -c5 | tr '[:upper:]' '[:lower:]')
yearoptions=('c' 'd' 'f' 'g' 'h' 'j' 'k' 'l' 'm' 'n' 'p' 'q' 'r' 's' 't' 'v' 'w' 'x' 'y' 'z')
weekoptions=('1' '2' '3' '4' '5' '6' '7' '8' '9' 'c' 'd' 'f' 'g' 'h' 'j' 'k' 'l' 'm' 'n' 'p' 'q' 'r' 't' 'v' 'w' 'x' 'y')

## Work Area ###############################

echo "$serial"
echo "$yearval"
# getting the estimated year of manufacture based on Serial
searchYear

estYear=$((2010 + ${yearval}/2 ))
estYearHalf=$((${yearval} % 2))

echo $estYear
echo $estYearHalf

# getting getting the estimated week of manufacture based on Serial 
searchWeek

estWeek=$(( ${weekval} + ${estYearHalf}*26 -1 ))
echo $estWeek

week_day_of_Jan_1="$(date -j -f "%Y%m%d" "20160101" +%w)"
if [[ $week_day_of_Jan_1 == "1" ]]; then
	first_Mon="${estYear}0101"
	echo $first_Mon
else
	
	day=$((01 + (07 - ${week_day_of_Jan_1} + 01) ))

		first_Mon=${estYear}010${day}
		echo $first_Mon
	
fi
    result=$(date -j -f %Y%m%d -v+${estWeek}w $first_Mon '+%A %B %d , %Y')


echo "<result>The week of $result</result>"
