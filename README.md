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

