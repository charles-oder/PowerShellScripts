
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
