$pathToApp = 'C:\dev\tools\actions-runner\workflow-usa\dataplus-client\dataplus-client\publish'


New-Item -Path $pathToApp -Name "app_offline.htm" -ItemType "file"

# Provide script commands here to deploy the app

Remove-Item -Path $pathToApp\app_offline.htm