<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from neonprimetime's PhishingKitTracker using PowerShell.

    .EXAMPLE
    Search-PhishingKitTracker | Format-List

    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-PhishingKitTracker {
    [CmdletBinding()]
    param()
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $ReponseType = 'CSV'
        $Uri = 'https://raw.githubusercontent.com/neonprimetime/PhishingKitTracker/master/PhishingKitTracker.csv'
        $ExtraRequestParams = ''
    }
    Process {Search-Api }
    End {Reset-SslDefaults; Write-Verbose 'Complete'}
}