 # Disable-IAMUser.ps1
# Automates secure offboarding of users in Active Directory

param(
    [Parameter(Mandatory=$true)]
    [string]$SamAccountName
)

# Retrieve the user from Active Directory
$User = Get-ADUser -Identity $SamAccountName -Properties MemberOf

# Remove the user from all group memberships except Domain Users
foreach ($Group in $User.MemberOf) {
    Remove-ADGroupMember -Identity $Group -Members $SamAccountName -Confirm:$false
}

# Disable the user account
Disable-ADAccount -Identity $SamAccountName

# Move the user to the Disabled Users OU
Move-ADObject -Identity $User.DistinguishedName -TargetPath "OU=Disabled Users,DC=iamlab,DC=local"

# Update the user description with termination information
Set-ADUser -Identity $SamAccountName -Description "Disabled on $(Get-Date -Format 'yyyy-MM-dd') by IAM offboarding script"

# Display success message
Write-Host "User $SamAccountName was offboarded successfully." -ForegroundColor Green
Write-Host "Actions completed:"
Write-Host "- Removed from all groups"
Write-Host "- Account disabled"
Write-Host "- Moved to Disabled Users OU"
Write-Host "- Description updated with termination date"
