#!/bin/bash
api_token=$CF_API_TOKEN
zone=$CF_ZONE_NAME
domain=$CF_RECORD_NAME

# get your external ip v4 address
ip_addr=`dig -4 TXT +short o-o.myaddr.1.google.com @ns1.google.com`


# get zones
zones_json=`curl -s https://api.cloudflare.com/client/v4/zones -H "content-type: application/json" -H "authorization: Bearer $api_token"`

if [ `echo $zones_json | jq -r '.success'` == 'false' ];then
    echo "failed to get zones"
    exit 1
fi

zone_id=`echo $zones_json | jq -r ".result[] | select(.name==\"$zone\") | .id"`
if [ $zone_id ]; then
    echo zone id: $zone $zone_id
else
    echo "zone '$zone' not found"
    exit 1
fi


# get dns records
dns_records=`curl -s https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records -H "content-type: application/json" -H "authorization: Bearer $api_token"`

if [ `echo $dns_records | jq -r '.success'` == 'false' ];then
    echo "failed to get dns records"
    exit 1
fi

record_id=`echo $dns_records | jq -r ".result[] | select(.name == \"$domain\") | .id"`
if [ $record_id ]; then
    echo record id: $domain $record_id
    echo update record
else
    echo "domain '$domain' not found"
    echo create record
fi


# update or create record
update_query=" \
{ \
    \"type\": \"A\", \
    \"name\": \"$domain\", \
    \"content\": $ip_addr, \
    \"ttl\": 1 \
}"

[ $record_id ] && method='PUT' || method='POST'

update_result=`curl -s https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id -X $method\
                -H "Content-Type: application/json"\
                -H "authorization: Bearer $api_token"\
                -d "$update_query"`

if [ `echo $update_result | jq -r '.success'` == 'true' ];then
    echo 'completed'
else
    echo 'error'
fi