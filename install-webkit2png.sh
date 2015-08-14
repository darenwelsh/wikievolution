#!/bin/sh
#
# Install webkit2png

print_title "Starting script install-webkit2png.sh"


if [ "$(whoami)" != "root" ]; then
	echo "Try running this script with sudo: \"sudo bash install-webkit2png.sh\""
	exit 1
fi

# Get webkit2png
echo "Downloading and installing webkit2png"
cd ~
wget https://raw.github.com/paulhammond/webkit2png/master/webkit2png
mv ./webkit2png /usr/local/bin/webkit2png
chmod a+x /usr/local/bin/webkit2png

echo "Complete!"
