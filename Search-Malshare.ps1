<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from Malshare using PowerShell.

    .EXAMPLE
    Search-Malshare -ApiKey <APIKEY> -Query 4cc96f0003b6c0429f29013a8d9e3e3c | Format-List


    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-Malshare {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ApiKey,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults
        
        $Uri = "https://malshare.com/api.php?api_key=$ApiKey&action=search&query=$Query".ToLower()
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}