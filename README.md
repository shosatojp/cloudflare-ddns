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
```


## Usage

use cron to update ip address regularly

```sh
crontab -e

# append this to update every hour
*/1 * * * * CF_RECORD_NAME=*.blog.shosato.jp CF_ZONE_NAME=shosato.jp /bin/bash -l /path/to/cloudflare-ddns/cfddns.sh
*/1 * * * * CF_RECORD_NAME=blog.shosato.jp CF_ZONE_NAME=shosato.jp /bin/bash -l /path/to/cloudflare-ddns/cfddns.sh
```

