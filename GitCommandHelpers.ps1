
if (Get-Module -ListAvailable -Name posh-git) {
    Write-Host "posh-git is installed"
}
else {
    Write-Host "posh-git is not installed"
    $(PowerShellGet\Install-Module posh-git -Scope CurrentUser)
}


Import-Module posh-git
Start-SshAgent

function devs {
    $Script:devs = $args
}

function story([String] $story) {
    $Script:story = $story
}

function getCommitMessage {
    $message = ""
    if ($Script:story -ne $null -and $Script:story -ne "") {
        $message += $Script:story + " -"
    }

    foreach ($line in $args) {
        if ($message -ne "") {
            $message += " "
        }
        $message += $line
    }

    if ($Script:devs -ne $null -and $Script:devs -ne "") {
        $message += " [" + [String]::Join(" ", $Script:devs) + "]"
    }

    return $message
}

function ci {
    $message = $(getCommitMessage $args)
    git commit -m "$message"
}

function cia {
    git add .
    $message = $(getCommitMessage $args)
    git commit -m "$message"
}

function amend {
    git commit --amend --no-edit
}

function backoutGit {
    git reset --hard HEAD~
}

function rebaseLastPull {
    backoutGit
    git pull --rebase
}

function resetSubmodules {
    git submodule foreach git reset --hard
    git submodule foreach git clean -dfx
}
