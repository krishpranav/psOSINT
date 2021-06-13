
<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from ThreatCrowd using PowerShell.

    .EXAMPLE
    Search-ThreatCrowd -Endpoint ip -Query 188.40.75.132 | Format-List


    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-ThreatCrowd {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("email", "domain", "ip", "resource")]
        [string]$Endpoint,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $Endpoint = "$Endpoint".ToLower()
        $BaseUri = "https://www.threatcrowd.org/searchApi/v2/$Endpoint"

        if ($Endpoint -eq "resource") {
            $BaseUri = "https://www.threatcrowd.org/searchApi/v2/file"
        }

        $Uri = "$BaseUri/report/`?$Endpoint=$Query"
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}