function Get-ServerNetworkHealth {
  param (
    [string[]]$ServerNames = @("dc01", "dc02")
  )

  if (-not $cred) {
    $cred = Get-Credential -Message "Enter credentials for remote servers"
  }
  
  Invoke-command -computername $ServerNames -Credential $cred -ScriptBlock {

    $Dns = dcdiag /test:dns /q
    $Dhcp = Get-Service DHCPServer -ErrorAction SilentlyContinue
    
    [PSCustomObject]@{
      ServerName = $env:COMPUTERNAME
      DnsHealth  = if ($null -eq $Dns) { "Pass" } else { "Check Errors" }
      DhcpStatus = $Dhcp.Status
    }

  } -asjob
  Write-host "fetching network health data from servers..." -ForegroundColor Green
}
