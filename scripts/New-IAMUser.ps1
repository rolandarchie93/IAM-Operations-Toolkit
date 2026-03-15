# New-IAMUser.ps1
# Automates provisioning of new users in Active Directory

Start-Trancript -Path "C:\logs\IAM-Toolkit.log" -Append

param(
    [Parameter(Mandatory=$true)]
    [string]$FirstName,

    [Parameter(Mandatory=$true)]
    [string]$LastName,

    [Parameter(Mandatory=$true)]
    [string]$Department

    [Parameter(Mandatory=$true)]
    [SecureString]$Password
)

try {

# Generate username
$Username = ($FirstName.Substring(0,1) + $LastName).ToLower()

# Create User Principal Name
$UPN = "$Username@iamlab.local"


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
switch ($Department) {
    "Finance" { $GroupName = "FIN_Modify" }
    "HR"      { $GroupName = "HR_Modify" }
    "IT"      { $GroupName = "IT_Modify" }
    "Sales"   { $GroupName = "SAL_Modify" }
    "Executive" { $GroupName = "EXEC_Modify" }
}

Add-ADGroupMember -Identity $GroupName -Members $Username 

# Display success message
Write-Host "User $FirstName $LastName created successfully." -ForegroundColor Green
Write-Host "Username: $Username"
Write-Host "Department: $Department"
Write-Host "RBAC Group Assigned: $GroupName"
}

catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
}


Stop-Transcript
