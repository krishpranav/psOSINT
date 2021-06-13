<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from VirusTotal using PowerShell.

    .EXAMPLE
    Search-VirusTotal -ApiKey <APIKEY> -Endpoint ip-address -Query 12.34.567.89 | Format-List

    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-VirusTotal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ApiKey,
        [Parameter(Mandatory=$true)]
        [ValidateSet("file", "url", "domain", "ip-address")]
        [string]$Endpoint,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        Switch($Endpoint) {
            "file" {
                $VirusTotalParam = "resource"
                Break
            }
            "url" {
                $VirusTotalParam = "resource"
                Break
            }
            "ip-address" {
                $VirusTotalParam = "ip"
                Break
            }
        }

        $BaseUri = "https://www.virustotal.com/vtapi/v2/$Endpoint/report"
        $Uri = "$BaseUri`?apikey=$ApiKey&$VirusTotalParam=$Query".ToLower()
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}