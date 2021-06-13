# psOSINT
A osint tool built in powershell for windows

# Installation
```
git clone https://github.com/krishpranav/psOSINT
```

# usage:

- List available commands:
```ps1
Get-Module -ListAvailable
```

- Import the module:
```ps1
Import-Module psOSINT
```

- Or import manifest file manually:
```ps1
Import-Module psOSINT.psd1
```

- View module details:
```ps1
Get-Module psOSINT
```

- Review module help:
```ps1
Get-Help Search-<OSINT_SOURCE>
```

- Show Cmdlet examples:
```ps1
Get-Help Search-<OSINT_SOURCE> -Examples
```

# Examples
```ps1
Search-AlienVault -Endpoint IPv4 -Section general -Query 187.233.152.78 | Format-List
Search-Censys -Uid <UID> -Secret <SECRET> -Endpoint search -Index certificates -Query pandorasong.com | Format-List
Search-Crtsh -Query jotugaedorm.com -Wildcard | Format-List
Search-Cymon -Endpoint ip -Query 195.123.237.120 | Format-List
Search-EmailRep -Query bill@microsoft.com | Format-List
Search-GreyNoise -Endpoint list | Format-List
Search-GreyNoise -Endpoint tag -Query ADB_WORM | Format-List
Search-GreyNoise -Endpoint ip -Query 123.193.145.85 | Format-List
Search-HybridAnalysis -ApiKey <APIKEY> -Secret <SECRET> -Endpoint hash -Name hash -Query 116858001ed50d8dd02b353473a139b98820dcf620c9e70e8a51c49f62cc6581 | Format-List
Search-Malshare -ApiKey <APIKEY> -Query 4cc96f0003b6c0429f29013a8d9e3e3c | Format-List
Search-PhishingKitTracker | Format-List
Search-PulseDive -Endpoint threat -Query Zeus | Format-List
Search-PulseDive -Endpoint indicator -Query pulsedive.com | Format-List
Search-PulseDive -Endpoint feed_list | Format-List
Search-PulseDive -Endpoint feed -Query "Zeus Bad Domains" -organization abuse.ch | Format-List
Search-ThreatCrowd -Endpoint ip -Query 188.40.75.132 | Format-List
Search-ThreatMiner -Endpoint host -Query 216.58.192.174 -QueryType report_tagging | Format-List
Search-Urlhaus -Endpoint payload -Query 4ef1c08fe44a8d1e1c8ef214e7ed63a318663e926860702076bc6234fd3b1d11 | Format-List
Search-Urlscan -Query 4ef1c08fe44a8d1e1c8ef214e7ed63a318663e926860702076bc6234fd3b1d11 | Format-List
Search-VirusTotal -ApiKey <APIKEY> -Endpoint ip-address -Query 99.84.254.97 | Format-List
````

