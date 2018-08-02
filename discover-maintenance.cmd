@echo off
setlocal EnableDelayedExpansion



curl -s "https://catonrug.blogspot.com/feeds/posts/default/-/10.0.17134.165?alt=json-in-script&max-results=100" |^
sed "s/gdata.io.handleScriptLoaded(//;s/);$//" |^
jq ".[\"feed\"] | .[\"entry\"] | .[] | .id.\"$t\",(.link[] | select(.rel == \"alternate\").title)" |^
sed "s/tag:blogger.com,1999:blog-.*.post-//g"

endlocal

pause
