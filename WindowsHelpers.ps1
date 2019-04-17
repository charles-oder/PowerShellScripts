
function editEnvironmentVariables {
    rundll32 sysdm.cpl,EditEnvironmentVariables
}

function checkActiveDirectory {
    net user $env:UserName /domain
}

Write-Host "Windows Helpers Loaded"
