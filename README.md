# CloudFlare DDNS Shell Script

update a record with your external ip v4 address, create if not exists.

## Dependencies

* `dig`
* `curl`
* `jq`

## Settings

set following environment variables

```sh
# need following permissions: Zone.Zone.Read, Zone.DNS.Edit
# top right corner > My Profile > API Tokens > Create Token
export CF_API_TOKEN=AAAAABBBBBCCCCCDDDDDEEEEEFFFFF
export CF_ZONE_NAME=shosato.jp
# export CF_RECORD_NAME=mail.shosato.jp
```


## Usage

use cron to update ip address regularly

```sh
crontab -e

# append this to update every hour
0 */1 * * * CF_RECORD_NAME=mail.shosato.jp /bin/bash -l /**/**/cloudflare-ddns/cfddns.sh
```

