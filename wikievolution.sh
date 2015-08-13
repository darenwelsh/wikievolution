#!/bin/bash  

# download source of wiki page
# TODO name file uniquely so several people can run concurrently
#curl -o ./source.txt 'https://en.wikipedia.org/w/index.php?title=Emanuel_African_Methodist_Episcopal_Church&action=history'

# regex
re="/^.*/<a href=\"([^\" ]*?)\" title=\"([^\"]*?)\" class=\"mw-changeslist-date\">(\d\d):(\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class='history-user'><a href=\"([^\" ]*?)\"[^=\"\">]*?.*?>(.*?)</a>.*(<span class=\"comment\">(.*)</span>)?.*</span>"


# read the html, parse with regex and replace with output to new file
# cat ./source.txt | 
# 	while read line; do 
# 		while [[ $line =~ $re ]] ; do 
			var1=${BASH_REMATCH[1]}
			var2=${BASH_REMATCH[2]}
			var3=${BASH_REMATCH[3]}
			var4=${BASH_REMATCH[4]}
			var5=${BASH_REMATCH[5]}
			var6=${BASH_REMATCH[6]}
			var7=${BASH_REMATCH[7]}
			var8=${BASH_REMATCH[8]}
			var9=${BASH_REMATCH[9]}
 			output="https://en.wikipedia.org$var1\t$var7-$var6-$var5T$var3$var4\thttps://en.wikipedia.org$var8\t$var9\t$var2\r"
# 			sed -e $re -e $output ./output.txt
# 			#sed -i '$output' ./output.txt
# 		done
# 	done


sed -i -E 's/$re/$output/g' ./output.txt

sed '\^\.\*<a href="(\[^" \]\*?)" title="(\[^"\]\*?)" class="mw-changeslist-date">(\d\d):(\d\d), (\d\d) (\.\[^ \]\*) (\d\d\d\d)</a>‎ <span class='\''history-user'\''><a href="(\[^" \]\*?)"\[^="">\]\*?\.\*?>(\.\*?)<\/a>\.\*(<span class="comment">(\.\*)<\/span>)?\.\*<\/span>/https:\/\/en.wikipedia.org\1\t\7-\6-\5T\3\4\thttps:\/\/en.wikipedia.org\8\t\9\t\2\r/g' ./output.txt


sed -i "" '\^\.\*<a href=\"(\[^" \]\*?)\" title=\"(\[^"\]\*?)\" class=\"mw-changeslist-date\">(\d\d):(\d\d), (\d\d) (\.\[^ \]\*) (\d\d\d\d)</a>‎ <span class='\''history-user'\''><a href=\"(\[^" \]\*?)\"\[^="">\]\*?\.\*?>(\.\*?)<\/a>\.\*(<span class=\"comment\">(\.\*)<\/span>)?\.\*<\/span>/https:\/\/en.wikipedia.org\1\t\7-\6-\5T\3\4\thttps:\/\/en.wikipedia.org\8\t\9\t\2\r/g' output.txt

sed -E '\^\.\*<a href=\"([^" ]\*?)\" title=\"([^"]\*?)\" class=\"mw-changeslist-date\">(\d\d):(\d\d), (\d\d) (\.[^ ]\*) (\d\d\d\d)</a>‎ <span class='\''history-user'\''><a href=\"([^" ]\*?)\"[^="">]\*?\.\*?>(\.\*?)<\/a>\.\*(<span class=\"comment\">(\.\*)<\/span>)?\.\*<\/span>/https:\/\/en.wikipedia.org\1\t\7-\6-\5T\3\4\thttps:\/\/en.wikipedia.org\8\t\9\t\2\r/g' output.txt

sed -E '<a href="([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d):(\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class='history-user'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">(.*)</span>)?.*</span>/https:\/\/en.wikipedia.org\1\t\7-\6-\5T\3\4\thttps:\/\/en.wikipedia.org\8\t\9\t\2\r/g' output.txt

# 01 page URL
# 02 page title
# 03 change hours
# 04 change minutes
# 05 change date
# 06 change month
# 07 change year
# 08 author URL
# 09 author name


# ^.*<a href="([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d):(\d\d), (\d\d) June 2015</a>‎ <span class='history-user'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">.*</span>)?.*</span>

# ^.*<a href="([^" ]*?)" title="([^"]*?)" class="mw-changeslist-date">(\d\d):(\d\d), (\d\d) (.[^ ]*) (\d\d\d\d)</a>‎ <span class='history-user'><a href="([^" ]*?)"[^="">]*?.*?>(.*?)</a>.*(<span class="comment">(.*)</span>)?.*</span>

# https://en.wikipedia.org\1\t\7\-\6\-\5T\3\4\thttps://en.wikipedia.org\8\t\9\t\2\r
