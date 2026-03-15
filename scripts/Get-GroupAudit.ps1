 # Get-GroupAudit.ps1

Start-Trancript -Path "C:\logs\IAM-Toolkit.log" -Append

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName
)

try {

    # Retrieve the user from Active Directory
    $User = Get-ADUser -Identity $SamAccountName -Properties MemberOf

    Write-Host "Group memberships for $SamAccountName:" -ForegroundColor Cyan
   
    foreach ($Group in $User.Memberof) {
        $GroupName = (Get-ADGroup $Group).Name
        Write-Host "- $GroupName"
    }
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
}


Stop-Transcript