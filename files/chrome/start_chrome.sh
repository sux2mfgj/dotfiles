#!/bin/sh

inbox=https://inbox.google.com/u/0/

# line_app_id=menkifleemblimdogmoihpfopnplikde

addresses=${inbox} 

# google-chrome-stable --app-id=${line_app_id} > /dev/null 2>&1 &
google-chrome-stable ${addresses} > /dev/null 2>&1 

