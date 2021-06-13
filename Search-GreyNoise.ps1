<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from GreyNoise using PowerShell.

    .EXAMPLE
    Search-GreyNoise -Endpoint list | Format-List

    status : ok
    tags   : {VNC_SCANNER_HIGH, PING_SCANNER_LOW, BINGBOT, IIS_WEBDAV_REMOTE_CODE_EXECUTION_CVE_2017_7269...}

    .EXAMPLE
    Search-GreyNoise -Endpoint tag -Query ADB_WORM | Format-List


    .EXAMPLE
    Search-GreyNoise -Endpoint ip -Query 123.193.145.85 | Format-List


    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-GreyNoise {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Key,

        [Parameter(Mandatory=$true)]
        [ValidateSet("list", "ip", "tag")]
        [string]$EndPoint,
        [Parameter(Mandatory=$false)]
        [ValidateScript({
            if ($EndPoint -ne "list") {
                $true
            } else {
                Throw "Value Mismatch Detected: list (Query not needed)."
            }
        })]
        [string]$Query
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        $Uri = "https://api.greynoise.io/v1/query/$EndPoint".ToLower()

        if ($EndPoint -ne "list") {
            $Query = $Query.ToUpper()
            $Body = "@{$EndPoint='$Query';key='$Key'}"
            $Method = "POST"
            $Uri = "https://api.greynoise.io/v1/query/$EndPoint".ToLower()
            $ExtraRequestParams = "-Body $Body"
        }
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}