# CloudFlare DDNS Shell Script

## Dependencies

* `dig`
* `curl`
* `jq`

## Settings

set following environment variables

```sh
# need following permissions: Zone.Zone, Zone.DNS
export CF_API_TOKEN=AAAAABBBBBCCCCCDDDDDEEEEEFFFFF
export CF_ZONE_NAME=shosato.jp
export CF_RECORD_NAME=mail.shosato.jp
```


## Usage

use cron to update ip address regularly

```sh
crontab -e

# append this to update every hour
0 */1 * * * /**/**/cloudflare-ddns/cfddns.sh
```

