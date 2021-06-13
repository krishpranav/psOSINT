<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from PulseDive using PowerShell.

    .EXAMPLE
    Search-PulseDive -Endpoint threat -Query Zeus | Format-List

    .EXAMPLE
    Search-PulseDive -Endpoint indicator -Query pulsedive.com | Format-List

    .EXAMPLE
    Search-PulseDive -Endpoint feed_list | Format-List
    
    .EXAMPLE
    Search-PulseDive -Endpoint feed -Query "Zeus Bad Domains" -organization abuse.ch | Format-List

    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-PulseDive {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$ApiKey,
        [Parameter(Mandatory=$true)]
        [ValidateSet('indicator', 'threat', 'feed', 'feed_list')]
        [string]$Endpoint,
        [Parameter(Mandatory=$false)]
        [ValidateScript({

            if ($Endpoint -ne 'feed_list') {$true}
        })]
        [string]$Query,
        [Parameter(Mandatory=$false)]
        [ValidateScript({

            if ($Endpoint -eq 'feed') {$true}
        })]
        [string]$Organization

    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $Uri = 'https://pulsedive.com/api/info.php'
        $Endpoint = $Endpoint.ToLower()
        $Body = "@{$Endpoint='$Query';pretty=1;key='$ApiKey'}"
        $ExtraRequestParams = "-Body $Body"

        Switch ($Endpoint) {
            'feed' {
                $Body = "@{$Endpoint='$Query';organization='$Organization';pretty=1;key='$ApiKey'}"
                $ExtraRequestParams = "-Body $Body"
            }
            'feed_list' {
                $Uri = 'https://pulsedive.com/api/search.php?category%5B%5D=general&category%5B%5D=abuse&category%5B%5D=apt&category%5B%5D=attack&category%5B%5D=botnet&category%5B%5D=crime&category%5B%5D=exploitkit&category%5B%5D=fraud&category%5B%5D=group&category%5B%5D=malware&category%5B%5D=proxy&category%5B%5D=pup&category%5B%5D=rat&category%5B%5D=reconnaissance&category%5B%5D=spam&category%5B%5D=phishing&category%5B%5D=terrorism&category%5B%5D=vulnerability&search=feed&splitrisk=true&sanitize=true'
                $ReponseType = 'JSON'
            }
        }
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose 'Complete'}
}