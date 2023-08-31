param
(    
    #variables Restore && Build && Publish
    [Parameter(Mandatory=$true)]
  
    [string]$Project=$true,
    [string]$Configuration=$true,
    [switch]$Restore,
    [switch]$Build,
    [switch]$Test,
    [switch]$Publish,
    [switch]$PreDeploy,
    [switch]$Deploy,

    $Output = "",
    # variables PreDeploy && Deploy
    $WebSiteName = "deployment333124",
    $Domain_name = "deployment.com333124",
    $PhysicalPath = "",
    $Port = 80

)

    
$ErrorActionPreference = "stop"

if ($Restore) {
    # Start build process.
    & dotnet restore $Project
    if(!$?) { Exit $LASTEXITCODE }
}

if ($Build) {
    # Start build process.
    & dotnet build --configuration $Configuration --no-restore  $Project
    if(!$?) { Exit $LASTEXITCODE }
}

if ($Test) {
}

if ($Publish) {
    # Starting publish
    & dotnet publish --configuration $Configuration --no-build  $Project --output $Output
    if(!$?) { Exit $LASTEXITCODE }
}


if ($Deploy) {
    & Import-Module WebAdministration

    & $website = Get-Website -Name $WebSiteName
    if ($website -eq $null -or $website -eq '') {
       & New-WebAppPool -Name $WebSiteName
       & New-Website -Name $WebSiteName -ApplicationPool $WebSiteName -HostHeader $Domain_name -PhysicalPath $PhysicalPath -Port $Port
    } else {
       & Set-ItemProperty ('IIS:\Sites\' + $WebSiteName) -Name physicalPath -Value $PhysicalPath
    } 
       if(!$?) { Exit $LASTEXITCODE }
}

# samples
#  ./build.ps1 -Restore -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Build -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Test -Project "src/api.datasub.csproj"
#  ./build.ps1 -Publish -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -PreDeploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID -DeployUrl $CI_WEBSITE_URL
##  ./build.ps1 -Deploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID
