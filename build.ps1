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

    # variables PreDeploy && Deploy
    $WebSiteName = "testuzqaz",
    $Domain_name = "test.uzqaz",
    $PathCurrentInfo = "B:\dev\dataplus-client\_work\dataplus-client\dataplus-client",
    $PathNewInfo = "B:\dev\dataplus-client\_work\dataplus-client\dataplus-demo",
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
    & dotnet publish --configuration $Configuration --no-build  $Project --output ${github.sha}
    if(!$?) { Exit $LASTEXITCODE }
}

if ($PreDeploy) {

    # Import web module
      & Import-Module WebAdministration
    # create application pool in IIS
      & New-WebAppPool -Name $WebSiteName  
    # create new web site in IIS
      & New-Website -Name $WebSiteName -ApplicationPool $WebSiteName -HostHeader $Domain_name -PhysicalPath $PathNewInfo  -Port $Port
    # copy new path
      & Copy-Item -Path "$PathCurrentInfo\*" -Destination "$PathNewInfo" -Recurse -Force -verbose
    
}

if ($Deploy) {
    #switch new path
    Set-Content $PathNewInfo\default.htm “PSCreated Default Page”
}

# samples
#  ./build.ps1 -Restore -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Build -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Test -Project "src/api.datasub.csproj"
#  ./build.ps1 -Publish -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -PreDeploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID -DeployUrl $CI_WEBSITE_URL
#  ./build.ps1 -Deploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID
