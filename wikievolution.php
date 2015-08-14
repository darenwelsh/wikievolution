<?php
// based on http://dltj.org/article/emanuel-african-methodist-episcopal-church-wikipedia-page-visualized/
// 
// Take source html from a MediaWiki wiki history page
// Generate animated gif of the evolution of that page over time
//

$file = file_get_contents('./test.txt', FILE_USE_INCLUDE_PATH);
// $file = file_get_contents('https://en.wikipedia.org/w/index.php?title=Emanuel_African_Methodist_Episcopal_Church&action=history');
// $file = file_get_contents('https://mod2.jsc.nasa.gov/wiki/EVA/index.php?title=Hard_Upper_Torso&action=history');

// regex for html code with info about each version of the page
/* 
$pattern = '!^.*<a href="([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d):(\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class=\'history-user\'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">(.*)</span>)?.*</span>.*!'; 
*/
// cut URL to isolate &
/*
$pattern = '^!.*<a href="([^&]*?)&([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d.\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class=\'history-user\'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">(.*)</span>)?.*</span>.*!';
*/
// remove ^
$pattern = '!.*<a href="([^&]*?)&([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d.\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class=\'history-user\'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">(.*)</span>)?.*</span>.*!';

// 01 page URL part 1
// add & beteen part 1 and part 2
// 02 page URL part 2
// 03 page title
// 04 change hours:minutes
// 05 change date
// 06 change month
// 07 change year
// 08 author URL
// 09 author name

// Reformat matches to useable strings
$replacement = "https://en.wikipedia.org$1\t$7\-$6\-$5T$4\thttps://en.wikipedia.org$8\t$9\t$3";
// url
// timestamp
// editorurl
// editor
// pagetitle

// alternate reformat just for webkit2png
$replacementtimestampandurl = "$7$6$5T$4 https://en.wikipedia.org$1&$2";

// Method to pull only relevant parts of source
preg_match_all($pattern, $file, $matches, PREG_SET_ORDER);

$matcheslist = ""; //init
foreach ($matches as $val) {
	// echo(preg_replace($pattern, $replacementtimestampandurl, $val[0]));
	$matcheslist .= $val[0] . "\n";
	$pagehistoryline = $val[0];
	$timestampandurl = preg_replace($pattern, $replacementtimestampandurl, $pagehistoryline);
	$timestampandurl2 = preg_replace('!(\d\d):(\d\d)!', '$1$2', $timestampandurl);
	$command = "webkit2png -W 1400 -H 3800 -F -o raw/$timestampandurl2";
	exec(escapeshellcmd($command));
	// echo($timestampandurl2 . "\n");
	sleep(5);
}
// End



$pagehistory = preg_replace($pattern, $replacement, $matcheslist);

$outputfile = 'page-history.txt';
file_put_contents($outputfile, $pagehistory);


// $handle = fopen("page-history.txt", "r");
// if ($handle) {
//     while (($line = fgets($handle)) !== false) {
//         // process the line read
//         IFS=$'\t' read url timestamp editorurl editor &lt; &lt;&lt;"$line";
//         webkit2png -W 1400 -H 3800 -F -o raw/$timestamp $url;
//         sleep 5;
//     }

//     fclose($handle);
// } else {
//     // error opening the file
// } 


// cat page-history.txt | \
//  while read line; do \
//    IFS=$'\t' read url timestamp editorurl editor &lt; &lt;&lt;"$line"; \
//    webkit2png -W 1400 -H 3800 -F -o raw/$timestamp $url; \
//    sleep 5; \
//  done




