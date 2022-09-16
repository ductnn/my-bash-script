url="https://ip-ranges.amazonaws.com/ip-ranges.json"
region="${1:-}"
service="${2:-}"


region="$(tr '[:upper:]' '[:lower:]' <<< "$region")"
if [ "$region" = global ]; then
    region=GLOBAL
fi

service="$(tr '[:lower:]' '[:upper:]' <<< "$service")"

if [ "$region" = list ]; then
    curl -sS "$url" |
    jq -r '.prefixes[] | [.region, .service] | @tsv' | sort -u
    exit 0
fi

curl -sSf "$url" |
jq -r "
    .prefixes[] |
    if(\"$region\" != \"\" and \"$region\" != \"all\") then
        select(.region == \"$region\")
    else
        .
    end |
    if(\"$service\" != \"\" and \"$service\" != \"all\") then
        select(.service == \"$service\")
    else
        .
    end |
    .ip_prefix
"
