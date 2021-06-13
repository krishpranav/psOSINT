<#
    .SYNOPSIS
    Gather Open-Source Intelligence using PowerShell.
                 
    .DESCRIPTION
    Gather Open-Source Intelligence from Censys using PowerShell.
    .EXAMPLE
    Search-Censys -Uid <UID> -Secret <SECRET> -Endpoint search -Index certificates -Query pandorasong.com | Format-List
    status   : ok
    results  : {@{parsed.fingerprint_sha256=ff081d0526721b9217295e809e30fcea66e31f2ab0e0fc6699af222a24f5f6cc; parsed.issuer_dn=C=GB, ST=Greater Manchester, L=Salford, O=COMODO CA Limited, CN=COMODO RSA 
               Domain Validation Secure Server CA; parsed.subject_dn=OU=Domain Control Validated, OU=PositiveSSL, CN=pandorasong.com}, 
               @{parsed.fingerprint_sha256=216fda88168f10f19d5b217d5d718b90c950176224d24a97fcb2eea71a153f39; parsed.issuer_dn=C=GB, ST=Greater Manchester, L=Salford, O=COMODO CA Limited, CN=COMODO RSA 
               Domain Validation Secure Server CA; parsed.subject_dn=OU=Domain Control Validated, OU=PositiveSSL, CN=pandorasong.com}}
    metadata : @{count=2; query=pandorasong.com; backend_time=824; page=1; pages=1}
    ######################################################################
    Available options not found in 'Get-Help Search-Censys' SYNTAX section
    ######################################################################
    Endpoint: search
    Index   : [ipv4,websites,certificates]
    Query   : <STRING>
    Endpoint: view
    Index   : [ipv4,websites,certificates]
    Id      : <STRING>
    ENDPOINT: account
    ######################################################################
    Available options not found in 'Get-Help Search-Censys' SYNTAX section
    ######################################################################
    
    .LINK
    https://github.com/krishpranav/psOSINT/
#>


function Search-Censys {
    [CmdletBinding()]
}