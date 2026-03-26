 # Disable-IAMUser.ps1
# Automates secure offboarding of users in Active Directory

Start-Transcript -Path "C:\logs\IAM-Toolkit.log" -Append

param(
    [Parameter(Mandatory = $true)]
    [string]$SamAccountName
)

try {

# Retrieve the user from Active Directory
$User = Get-ADUser -Identity $SamAccountName -Properties MemberOf, DistinguishedName, UserPrincipalName

# Remove the user from all group memberships except Domain Users
foreach ($Group in $User.MemberOf) {
    Remove-ADGroupMember -Identity $Group -Members $SamAccountName -Confirm:$false
}

# Disable the user account
Disable-ADAccount -Identity $SamAccountName

# Move the user to the Disabled Users OU
Move-ADObject -Identity $User.DistinguishedName -TargetPath "OU=Disabled Users,DC=iamlab,DC=local"

# Update the user description with termination information
Set-ADUser -Identity $SamAccountName -Description "Disabled on $(Get-Date -Format 'yyyy-MM-dd')"

# Display success message
Write-Host "User $SamAccountName was offboarded successfully." -ForegroundColor Green
Write-Host "Actions completed:"
Write-Host "- Removed from all groups"
Write-Host "- Account disabled"
Write-Host "- Moved to Disabled Users OU"
Write-Host "- Description updated with termination date"
}
  catch {
     Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}



# --- Start of Hybrid Termination Block ---

Write-Host "Proceeding with cloud session revocation for $SamAccountName..."

try {

    Import-Module Microsoft.Graph.Authentication
    Import-Module Microsoft.Graph.Users.Actions

    Connect-MgGraph -Scopes "User.ReadWrite.All", "AuditLog.Read.All"

    $userObject = Get-ADUser -Identity $SamAccountName -Properties UserPrincipalName
    $upn = $userObject.UserPrincipalName

    Write-Host "Executing session revocation for UPN: $upn"

    Revoke-MgUserSignInSession -UserId $upn -ErrorAction Stop

    Write-Host "SUCCESS: Cloud session revoked." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: Cloud session revocation failed." -ForegroundColor Red
}

Disconnect-MgGraph

# --- End of Hybrid Termination Block ---

Stop-Transcript
