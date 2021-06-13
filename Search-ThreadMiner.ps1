<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from ThreatMiner using PowerShell.

    .EXAMPLE
    Search-ThreatMiner -Endpoint host -Query 216.58.192.174 -QueryType report_tagging | Format-List


    .LINK
    https://github.com/krishpranav/psOSINT/
#>
function Search-ThreatMiner {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("domain", "host", "sample", "imphash", "ssdeep", "ssl", "email", "av", "reports")]
        [string]$Endpoint,
        [Parameter(Mandatory=$true)]
        [string]$Query,
        [Parameter(Mandatory=$true)]
        [ValidateSet("av_detection", "domains", "hosts", "http_traffic", "metadata", "mutants", "passive_dns", "registry_keys", "report_names", "report_tagging", "reports_by_year", "samples", "ssl_hashes", "subdomains", "uris", "whois")]
        [ValidateScript({
            #
            # Mismatch detected. Use 'Get-Help Search-ThreatMiner -Examples' to see available options.
            #
            if ($Endpoint -eq "domain") {
                if ($_ -in @("whois","passive_dns","uris","samples","subdomains","report_tagging")) {$True}
            } elseif ($Endpoint -eq "host") {
                if ($_ -in @("whois","passive_dns","uris","samples","ssl_hashes","report_tagging")) {$True}
            } elseif ($Endpoint -eq "sample") {
                if ($_ -in @("metadata","http_traffic","hosts","mutants","registry_keys","av", "report_tagging")) {$True}
            } elseif ($Endpoint -eq "imphash") {
                if ($_ -in @("samples","report_tagging")) {$True}
            } elseif ($Endpoint -eq "ssdeep") {
                if ($_ -in @("samples","report_tagging")) {$True}
            } elseif ($Endpoint -eq "ssl") {
                if ($_ -in @("hosts","report_tagging")) {$True}
            } elseif ($Endpoint -eq "email") {
                if ($_ -in @("domains")) {$True}
            } elseif ($Endpoint -eq "av") {
                if ($_ -in @("samples","report_tagging")) {$True}
            } elseif ($Endpoint -eq "reports") {
                if ($_ -in @("report_names","reports_by_year")) {$True}
            }
        })]
        [string]$QueryType
    )
    
    Begin {
        Set-SslDefaults
        Set-ModuleDefaults

        Switch ($Endpoint) {
            "domain"   {
                Switch ($QueryType) {
                    "whois"          {$Flag = 1;Break}
                    "passive_dns"    {$Flag = 2;Break}
                    "uris"           {$Flag = 3;Break}
                    "samples"        {$Flag = 4;Break}
                    "subdomains"     {$Flag = 5;Break}
                    "report_tagging" {$Flag = 6;Break}
                }
                Break
            }
            "host"     {
                Switch ($QueryType) {
                    "whois"          {$Flag = 1;Break}
                    "passive_dns"    {$Flag = 2;Break}
                    "uris"           {$Flag = 3;Break}
                    "samples"        {$Flag = 4;Break}
                    "ssl_hashes"     {$Flag = 5;Break}
                    "report_tagging" {$Flag = 6;Break}
                }
                Break
            }
            "sample"   {
                Switch ($QueryType) {
                    "metadata"       {$Flag = 1;Break}
                    "http_traffic"   {$Flag = 2;Break}
                    "hosts"          {$Flag = 3;Break}
                    "mutants"        {$Flag = 4;Break}
                    "registry_keys"  {$Flag = 5;Break}
                    "av_detection"   {$Flag = 6;Break}
                    "report_tagging" {$Flag = 7;Break}
                }
                Break
            }
            "imphash"  {
                Switch ($QueryType) {
                    "samples"        {$Flag = 1;Break}
                    "report_tagging" {$Flag = 2;Break}
                }
            }
            "ssdeep"   {
                Switch ($QueryType) {
                    "samples"        {$Flag = 1;Break}
                    "report_tagging" {$Flag = 2;Break}
                }
                Break
            }
            "ssl"      {
                Switch ($QueryType) {
                    "hosts"          {$Flag = 1;Break}
                    "report_tagging" {$Flag = 2;Break}
                }
                Break
            }
            "email"    {
                Switch ($QueryType) {
                    "domains" {$Flag = 1;Break}
                }
                Break
            }
            "av"       {
                Switch ($QueryType) {
                    "samples"        {$Flag = 1;Break}
                    "report_tagging" {$Flag = 2;Break}
                }
                Break
            }
            "aptnotes" {
                Switch ($QueryType) {
                    "report_names"    {$Flag = 1;Break}
                    "reports_by_year" {$Flag = 2;Break}
                }
                Break
            }
        }

        $BaseUri = "https://api.threatminer.org/v2/$Endpoint.php".ToLower()
        $Uri = "$BaseUri`?q=$Query&rt=$Flag"
    }
    Process {Search-Api}
    End {Reset-SslDefaults; Write-Verbose "Complete"}
}