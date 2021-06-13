<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from urlscan.io using PowerShell.

    .EXAMPLE
    Search-Urlscan -Query 4ef1c08fe44a8d1e1c8ef214e7ed63a318663e926860702076bc6234fd3b1d11 | Format-List

    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-Urlscan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $ReponseType = "OBJ"
        $Uri = "https://urlscan.io/api/v1/search/`?q=$Query&size=10000".ToLower()
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}