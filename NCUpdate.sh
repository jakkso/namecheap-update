#!/usr/bin/env bash

updateDomains() {
  domain=yourdomain.tld
  password=yourpasswordhere
  for hostname in @ www
    do
      curl -s "https://dynamicdns.park-your-domain.com/update?host=$hostname&domain=$domain&password=$password&ip=$ipAd$
    done
}

# Read in cached ip address
test -f "ip.txt" && currentIp=`cat "ip.txt"`
ipAddr=`curl -s 'https://api.ipify.org'`

# Exit out early if address is the same
if [[ $currentIp = $ipAddr ]]; then
        echo "`date` ip address unchanged"
        exit 0
else # Cache address & update namecheap
        echo $ipAddr > "ip.txt"
        updateDomains
        echo "`date` ip address changed to $ipAddr"
fi
