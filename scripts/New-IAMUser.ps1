# New-IAMUser.ps1
# Automates provisioning of new users in Active Directory

param(
    [Parameter(Mandatory=$true)]
    [string]$FirstName,

    [Parameter(Mandatory=$true)]
    [string]$LastName,

    [Parameter(Mandatory=$true)]
    [string]$Department
)

# Generate username
$Username = ($FirstName.Substring(0,1) + $LastName).ToLower()

# Create User Principal Name
$UPN = "$Username@iamlab.local"

# Temporary password
$Password = ConvertTo-SecureString "TempP@ssw0rd123!" -AsPlainText -Force

# Create Active Directory user
New-ADUser `
    -Name "$FirstName $LastName" `
    -GivenName $FirstName `
    -Surname $LastName `
    -SamAccountName $Username `
    -UserPrincipalName $UPN `
    -AccountPassword $Password `
    -Enabled $true `
    -Path "OU=$Department,OU=Departments,DC=iamlab,DC=local"

  # Assign RBAC group
$GroupName = "$Department`_Modify"

Add-ADGroupMember -Identity $GroupName -Members $Username 

# Display success message
Write-Host "User $FirstName $LastName created successfully." -ForegroundColor Green
Write-Host "Username: $Username"
Write-Host "Department: $Department"
Write-Host "RBAC Group Assigned: $GroupName"
