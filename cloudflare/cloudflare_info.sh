#!/bin/bash

api_key='XXXXXXXXX'
zone_id='XXXXXXXXX'
mail='XXXXXXXXX'

result=`curl --silent -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/firewall/access_rules/rules?match=all" \
     -H "X-Auth-Email: $mail" \
     -H "X-Auth-Key: $api_key" \
     -H "Content-Type: application/json"`

echo "$result"


number_rule=`echo "$result" | grep "total_count" | awk {'print $2'} | tr -dc '0-9'`
echo "Total rules: $number_rule"

id_rulelist=`echo "$result" | grep '"id":' | sed "/.*$zone_id.*/d" | awk {'print $2'} | tr -d ','|tr -d '"'`
echo "==== ID list ===="
echo "$id_rulelist"
