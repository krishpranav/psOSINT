<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from URLhaus using PowerShell.

    .EXAMPLE
    Search-Urlhaus -Endpoint payload -Query 4ef1c08fe44a8d1e1c8ef214e7ed63a318663e926860702076bc6234fd3b1d11 | Format-List


    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-Urlhaus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("url", "host", "payload")]
        [string]$Endpoint,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $Body = "@{$Endpoint='$Query'}"
        $Method = "POST"

        if ($Endpoint -eq "payload") {
            if ($Query.Length -eq 32) {
                $Body = "@{md5_hash='$Query'}"
            } elseif ($Query.Length -eq 64) {
                $Body = "@{sha256_hash='$Query'}"
            }
        }

        $Uri = "https://urlhaus-api.abuse.ch/v1/$Endpoint/".ToLower()
        $ExtraRequestParams = "-Body $Body"
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}