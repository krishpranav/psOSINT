<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from EmailRep.io using PowerShell.

    .EXAMPLE
    Search-EmailRep -Query bill@microsoft.com -ApiKey APIKEY | Format-List

    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-EmailRep {
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

        $UserAgent = "Mozilla/5.0 (Windows NT 10.0; Microsoft Windows 10.0.15063; en-US) PowerShell/6.0.0"
        $Uri = "https://emailrep.io/$Query".ToLower()
        $Body = "@{Key='$ApiKey'}"
        $ExtraRequestParams = "-Body $Body"
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}