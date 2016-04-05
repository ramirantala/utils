#!/bin/bash

chromecli="/usr/local/bin/chrome-cli"
window1="https://www.google.com"
window1_tabs="https://www.google.com https://www.google.com"
window1_position=-1920

window2="https://www.google.com"
window2_tabs="https://www.google.com https://www.google.com"
window2_position=0

function open_url_in_new_window() {
   local url=$1

   $chromecli open $url -n >/dev/null
   # is the latest window really on top?
   local window=`$chromecli list windows | sort -n -k 1 -r | head -1 | cut -d" " -f1 | tr -d "[]"`
   $chromecli list windows >windows.txt
   echo $window
}

function open_urls_in_tab() {

	local urls=$1
	local window=$2

	for url in $urls; do
 	 	echo "chrome-cli open $url -w $window"
		$chromecli open $url -w $window
	done

}

function close_all_chrome_windows() {

   local windows=`$chromecli list windows | while read x; do echo $x | cut -d" " -f1 | tr -d "[]"; done`

   for window in $windows; do
	$chromecli close -w $window
   done


}

close_all_chrome_windows

window=$(open_url_in_new_window $window1)
echo "WINDOW: $window"
open_urls_in_tab "$window1_tabs" $window
$chromecli position $window1_position 0 -w $window

window=$(open_url_in_new_window $window2)
echo "WINDOW: $window"
open_urls_in_tab "$window2_tabs" $window
$chromecli position $window2_position 0 -w $window

