#!/bin/sh

inbox='https://inbox.google.com/u/0/'
slack='https://slack.com/'
skype='https://web.skype.com/ja/'
tweetdeck='https://tweetdeck.twitter.com/'
aslweb='aslweb.u-aizu.ac.jp/aslint/'

# line_app_id=menkifleemblimdogmoihpfopnplikde

addresses=(${inbox} ${slack} ${skype} ${tweetdeck} ${aslweb})
echo ${addresses}

# google-chrome-stable --app-id=${line_app_id} > /dev/null 2>&1 &
google-chrome-stable ${addresses[@]} > /dev/null 2>&1 

