<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from AlienVault using PowerShell.
    .EXAMPLE
    Search-AlienVault -Endpoint IPv4 -Section general -Query 187.233.152.78 | Format-List
    sections       : {general, geo, reputation, url_list...}                                      
    city           : Aguascalientes                   
    area_code      : 0                               
    pulse_info     : @{count=8; references=System.Object[]; pulses=System.Object[]}      
    continent_code : NA                                  
    country_name   : Mexico                                                                    
    postal_code    : 20270                                 
    dma_code       : 0                                                                 
    country_code   : MX                                
    flag_url       : /static/img/flags/mx.png            
    asn            : AS8151 Uninet S.A. de C.V.                                   
    city_data      : True                            
    indicator      : 187.233.152.78                         
    whois          : http://whois.domaintools.com/187.233.152.78
    type_title     : IPv4                                   
    region         : AGU                                 
    charset        : 0                                                
    longitude      : -102.2705                               
    country_code3  : MEX                                    
    reputation     : 0                                                            
    base_indicator : @{indicator=187.233.152.78; description=; title=; access_reason=; access_type=public; content=; type=IPv4; id=1818097001}
    latitude       : 21.8956                                
    type           : IPv4                                   
    flag_title     : Mexico
    ##########################################################################
    Available options not found in 'Get-Help Search-AlienVault' SYNTAX section
    ##########################################################################
    Endpoint: IPv4
    Section : [general,geo,http_scans,malware,passive_dns,reputation,url_list]
    Query   : STRING
    Endpoint: IPv6
    Section : [general,geo,http_scans,malware,passive_dns,reputation]
    Query   : STRING
    Endpoint: domain
    Section : [general,geo,http_scans,malware,passive_dns,url_list,whois]
    Query   : STRING
    Endpoint: hostname
    Section : [general,geo,http_scans,malware,passive_dns,url_list]
    Query   : STRING
    Endpoint: file
    Section : [analysis,general]
    Query   : STRING
    Endpoint: url
    Section : [general,url_list]
    Query   : STRING
    Endpoint: cve
    Section : [general]
    Query   : STRING
    ##########################################################################
    Available options not found in 'Get-Help Search-AlienVault' SYNTAX section
    ##########################################################################
    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>

function Search-AlienVault {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("IPv4","IPv6","domain","hostname","file","url","cve")]
        [string]$Endpoint,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]

        [ValidateSet("analysis","general","geo","http_scans","malware","passive_dns","reputation","url_list","whois")]
        [ValidateScript({
            if ($Endpoint -eq "IPv4") {
                if ($_ -in @("general","geo","http_scans","malware","passive_dns","reputation","url_list")) {$True}
            } elseif ($Endpoint -eq "IPv6") {
                if ($_ -in @("general","geo","http_scans","malware","passive_dns","reputation")) {$True}
            } elseif ($Endpoint -eq "domain") {
                if ($_ -in @("general","geo","http_scans","malware","passive_dns","url_list","whois")) {$True}
            } elseif ($Endpoint -eq "hostname") {
                if ($_ -in @("general","geo","http_scans","malware","passive_dns","url_list")) {$True}
            } elseif ($Endpoint -eq "file") {
                if ($_ -in @("analysis","general")) {$True}
            } elseif ($Endpoint -eq "url") {
                if ($_ -in @("general","url_list")) {$True}
            } elseif ($Endpoint -eq "cve") {
                if ($_ -in @("general")) {$True}
            }
        })]
        [string]$Section,
        [Parameter(Mandatory=$true)]
        [string]$Query
    )

    Begin {
        Set-SslDefaults
        Set-ModuleDefaults
    }

}