## Get-ServerNetworkHealth


## What does it do
Runs a quick network health check across multiple servers simultaneously. For each server it checks:

- DNS health via dcdiag /test:dns
- DHCP service status

Results come back as a clean custom object per server. Runs as a background job so it doesn't just sit there freezing your terminal while it waits.

## What does it solve
Checking DNS and DHCP health one server at a time is slow and annoying. This fires them all off in parallel and gives you a consistent output format instead of raw dcdiag noise.


## Who's it for
Sysadmins who want a quick sanity check on their DC network health without clicking around or waiting on servers one by one.


## Requirements

PowerShell with the ActiveDirectory module (RSAT)
dcdiag available on the remote servers
Credentials with access to the target servers — the function will prompt via Get-Credential if $cred isn't already set in your session

## Limitations

- The DNS check is a bit naive — dcdiag /q returns nothing on a clean run, so $null = Pass. Not bulletproof but good enough for a quick check
- DHCP check will return empty on servers that don't have the DHCPServer role — won't error out, just blank
- -AsJob means results don't come back automatically — you'll need Receive-Job to actually see the output
- $cred scope isn't fully ironed out yet — works fine if you have $cred loaded in your session already

## Notes
- Work in progress — job handling and credential logic will be cleaned up in the next iteration.
