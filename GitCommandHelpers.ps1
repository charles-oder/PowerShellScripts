
if (Get-Module -ListAvailable -Name posh-git) {
    Write-Host "posh-git is installed"
}
else {
    Write-Host "posh-git is not installed"
    $(PowerShellGet\Install-Module posh-git -Scope CurrentUser)
}


Import-Module posh-git
Import-Module posh-sshell
Start-SshAgent

function devs {
    $Script:devs = $args
}

function story([String] $story) {
    $Script:story = $story
}

function localGit {
    $git_ip = $args[0]
    if ($args[1] -ne $null -and $args[1] -ne "") {
        $git_dir = $args[1]
    } else {
        $git_dir = $(get-location).Path.Split('\')[-1]
    }
    $git_path = "$git_ip/Users/git/$git_dir"
    
    echo "setting location to $git_path"
    $Script:localGit = $git_path
}

function pushToLocal {
    $localRepo = $Script:localGit
    $sshString = "ssh://git@$localRepo"
    echo "pulling from $localRepo"
    git push $sshString $args
}

function fetchFromLocal {
    $localRepo = $Script:localGit
    $sshString = "ssh://git@$localRepo"
    echo "pulling from $localRepo"
    git fetch $sshString $args
}

function pullFromLocal {
    $localRepo = $Script:localGit
    $sshString = "ssh://git@$localRepo"
    echo "pulling from $localRepo"
    git pull $sshString $args
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
