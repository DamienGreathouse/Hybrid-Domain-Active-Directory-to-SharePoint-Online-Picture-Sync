#Get All Users in Tenent
$users = Get-User -ResultSize unlimited

#connect to Exchange Online
Connect-ExchangeOnline


#For Each loop to check for userphoto on profile
 foreach ($user in $users) {
              
        $Picture = Get-EXOMailbox -identity $user -Properties HasPicture -ErrorAction SilentlyContinue | Select UserPrincipalName, HasPicture, PrimarySmtpAddress
        
        #If User has a photo aknowedge and move on
        if ($Picture.HasPicture -eq $true)
            {
               Write-Host $user " has a picture" -ForegroundColor green
                $thumb.thumbnailPhoto | Set-Content Photo.jpg -Encoding byte
            Set-UserPhoto -Identity $user -PictureData ([System.IO.File]::ReadAllBytes("photo.jpg")) -Confirm:$False
            }
        #If user has no photo: fetch photo and upload to Exchange/SPO
        if ($Picture.HasPicture -eq $false)
            {
               Write-Host $user.Identity " does not have a picture" -ForegroundColor red
               
               $url = 

               Invoke-WebRequest $url -OutFile temp.jpg
               Set-UserPhoto -Identity $user -PictureData ([System.IO.File]::ReadAllBytes("temp.jpg")) -Confirm:$False

            }
        #a catch for whatever doesnt meet the above to options somehow
        else
            {
                Write-Host $user " something went wrong" -ForegroundColor Yellow
            }
 }
