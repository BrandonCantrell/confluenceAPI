#!/bin/bash
SEARCHSTRING="https://YOURCONFLUENCE/rest/api/content/search?cql=space=YOURSPACENAME%20and%20(label=%22old-label-1%22%20OR%20label=%22old-label-2%22)&limit=100"
echo $SEARCHSTRING


while read -r id; do
  curl -u user:password -X POST -H 'Content-Type: application/json' -d'[{"prefix":"global","name":"new-label-name"}]
  ' https://YOURCONFLUENCE/rest/api/content/$id/label &&
  curl -u user:password -X DELETE -H 'Content-Type: application/json' -d'[{"prefix":"global","name":"old-label-1"}]
  ' https://YOURCONFLUENCE/rest/api/content/$id/label?name=old-label-1 &&
  curl -u user:password -X DELETE -H 'Content-Type: application/json' -d'[{"prefix":"global","name":"old-label-2"}]
  ' https://YOURCONFLUENCE/rest/api/content/$id/label?name=old-label-2;
done < <(curl -u user:password $SEARCHSTRING | python -mjson.tool | awk '/id/ { gsub("\"|\,",""); print $2}')
