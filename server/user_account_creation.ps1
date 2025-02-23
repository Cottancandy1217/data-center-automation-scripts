# user_account_creation.ps1
# Creates a local user account on a Windows Server system.

# Configuration
$Username = "datacentertech" # Change this to the desired username
$Password = ConvertTo-SecureString "StrongP@sswOrd123!" -AsPlainText -Force # Change this to a strong password
$Description = "Data Center Technician Account"
$FullName = "Data Center Technician" # Optional, add full name
$Enabled = $true # Set to $false to create a disabled account
$PasswordNeverExpires = $true # Set to $false to enforce password expiration

# Create the user account
try {
    New-LocalUser -Name $Username -Password $Password -Description $Description -FullName $FullName -Enabled $Enabled -PasswordNeverExpires $PasswordNeverExpires
    Write-Host "User account '$Username' created successfully."
}
catch {
    Write-Error "Failed to create user account: $($_.Exception.Message)"
}

# Add user to local administrators group (Optional, use with caution)
try {
    Add-LocalGroupMember -Group "Administrators" -Member $Username
    Write-Host "User '$Username' added to the local Administrators group."
}
catch {
    Write-Warning "Failed to add user to the Administrators group: $($_.Exception.Message)"
}
