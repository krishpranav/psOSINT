<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from HybridAnalysis using PowerShell.

    .EXAMPLE
    Search-HybridAnalysis -ApiKey <APIKEY> -Endpoint hash -Name hash -Query 116858001ed50d8dd02b353473a139b98820dcf620c9e70e8a51c49f62cc6581 | Format-List

    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-HybridAnalysis {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$ApiKey,

        [Parameter(Mandatory=$true)]
        [ValidateSet('hash', 'terms')]
        [string]$Endpoint,
        [Parameter(Mandatory=$true)]
        [ValidateSet('authentihash', 'av_detect', 'context', 'country', 'domain', 'env_id', 'filename', 'filetype_desc', 'filetype', 'hash', 'host', 'imp_hash', 'port', 'similar_to', 'ssdeep', 'tag', 'url', 'verdict', 'vx_family')]
        [ValidateScript({
            #
            # Mismatch detected. Use 'Get-Help Search-HybridAnalysis -Examples' to see available options.
            #
            if ($Endpoint -eq 'hash') {
                if ($_ -in @('hash')) {$True}
            } elseif ($Endpoint -eq 'terms') {
                if ($_ -notin @('hash')) {$True}
            }
        })]
        [string]$Name,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $Body = "@{$Name='$Query'}"
        $Headers = "@{'Accept'='application/json';'api-key'='$ApiKey'}"
        $Method = 'POST'
        $UserAgent = 'Falcon Sandbox'
        $Uri = "https://www.hybrid-analysis.com/api/v2/search/$Endpoint".ToLower()
        $ExtraRequestParams = "-Body $($Body) -Headers $Headers"
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose 'Complete'}
}