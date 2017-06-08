#changing the owner for a list of groups.
$input = Read-Host -Prompt "Enter the new owner SAMAccountName:"
$owner = ""
$owner = Get-ADUser $input
if ($owner ) 
    {Write-Host "Onwer found in AD. Importing the groups from the current directory" -ForegroundColor Yellow 
     $groups = Get-Content .\groups.txt

     if($groups) 
        {Write-Host "Groups imported" -ForegroundColor Yellow 
        
        foreach($group in $groups)
                {if(Get-ADGroup $group)
                    {write-host "[$group] found. Changing owner" 
                     Set-ADGroup $group -ManagedBy $owner.SamAccountName
                    }
                 else {"[$group] not found in AD" }
                }
        
        
        
        
        }
        
        else{Write-Host "No groups in the provided TXT" -ForegroundColor Yellow }
        
      }
    else {Write-Host "Failed to find the user in AD. Script will exit" -ForegroundColor Yellow 
                             
        }
