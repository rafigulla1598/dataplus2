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

    $Output = "${GIHUB_SHA}",

    # variables PreDeploy && Deploy
    $WebSiteName = "testuzqaz",
    $Domain_name = "test.uzqaz",
    $PathCurrentInfo = "B:\dev\dataplus-client\_work\dataplus-client\dataplus-client",
    $PathNewInfo = "B:\dev\dataplus-client\dataplus-client-publish",
    $Port = 80

)

    $github.head_ref = ${GITHUB_REF#refs/heads/}
    $github.sha = $(git rev-parse --short "$GITHUB_SHA") 
    
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

if ($PreDeploy) {

    # copy new path
      & Copy-Item -Path ".\${ github.head_ref }.${ github.sha }\*" -Destination "B:\dev\dataplus-client\dataplus-client-publish\${ github.head_ref }.${ github.sha }" -Recurse -Force -verbose   
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
##  ./build.ps1 -Deploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID
