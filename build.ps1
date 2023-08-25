param
(
    [Parameter(Mandatory=$true)]
  
    [string]$Project=$true,
    [string]$Configuration=$true, 
    [switch]$Restore,
    [switch]$Build,
    [switch]$Test,
    [switch]$Publish
   # [switch]$PreDeploy,
   # [switch]$Deploy,

    #[string]$DeployWebsite,
    #[string]$DeployUrl,
    #[string]$DeployRoot,
    #[string]$DeployTag
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
    & dotnet publish --configuration $Configuration --no-build  $Project --output "./publish"
    if(!$?) { Exit $LASTEXITCODE }
}

if ($PreDeploy) {

    #Copy artifacts to new physical directory: $(CI_WEBSITES_ROOT)\$CI_WEBSITE_NAME\$CI_COMMIT_ID
    # Copy "obj/publish" to $(CI_WEBSITES_ROOT)\$CI_WEBSITE_NAME\$CI_COMMIT_ID

    # use WebAdminitration module for powershell, see https://learn.microsoft.com/en-us/powershell/module/webadministration/?view=windowsserver2022-ps
    #Check website whether it exists or not, if exists e; otherwise b;
    #Create website with specified name;
    #Set specified website url to the bindings;
    #Configure HTTPS bindings too with HARD coded CERT
    #continue next step
}

if ($Deploy) {
    #Switch website physical path to the new physical directory.
}


# samples
#  ./build.ps1 -Restore -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Build -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -Test -Project "src/api.datasub.csproj"
#  ./build.ps1 -Publish -Configuration TestInstance -Project "src/api.datasub.csproj"
#  ./build.ps1 -PreDeploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID -DeployUrl $CI_WEBSITE_URL
#  ./build.ps1 -Deploy -DeployRoot $CI_WEBSITES_ROOT -DeployWebsite $CI_WEBSITE_NAME -DeployTag $CI_COMMIT_ID
