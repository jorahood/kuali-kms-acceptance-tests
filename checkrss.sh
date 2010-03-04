#!/bin/sh
while :
  do
    curl -s 'https://uisapp2.iu.edu/confluence-prd//createrssfeed.action?types=page&sort=modified&showContent=true&spaces=Sage&labelString=acceptancetest&rssType=atom&maxResults=1000&timeSpan=1000&publicFeed=true&title=Sage+Features+Automated+Acceptance+Tests&showDiff=false' > /tmp/new_feed.xml
    diff /tmp/new_feed.xml /tmp/old_feed.xml > /dev/null ||\
    cd /opt/apps/sage-acceptance-tests/; \
    rm features/*.feature > /dev/null 2>&1; \
    /opt/ruby-enterprise/bin/cucumber -p sage > /dev/null 2>&1
    mv /tmp/new_feed.xml /tmp/old_feed.xml
    sleep 10
  done