# --------------------------------------------------------------
# Copyright (C) 2022: Snyder Business And Technology Consulting, LLC. - All Rights Reserved
#
# Licensing:
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# Date:
# January 31, 2022
#
# Author:
# Alexander Snyder
#
# Email:
# alexander@sba.tc
#
# Repository:
# https://github.com/thisguyshouldworkforus/powershell.git
#
# Dependency:
# Requires access to administrator privelages
#
# Description:
# A script to stop/start the Media Group on AwesomeSauce
# --------------------------------------------------------------

$ApplicationArray = Get-Process -Name 'Plex Media Server', Sonarr, SABnzbd, Tautulli, qbittorrent
foreach ($app in $ApplicationArray){
    if ($app){
        Stop-Process $app -Force
    }
}
Write-Output "`n`nStarting sleep`n`n"

Start-Sleep 10

Write-Output "`n`nStarting Apps!`n`n"

function ProcessValidator{
verifies input is a string
Assumes that input is a fully qualified exe path
verifies that file path exists
verifies that it is an executable file
checks to see if THAT process is running
if (not running){
    it executes that file and starts that process
    sleeps for 2 seconds
    verifies that process is now properly running
    return true
    } elseif (running){
        prints to standard out that it is running, continues in loop
        return false
    } else {
        # Log an error and exit.
    }
}

$FilePathArray = 'D:\Applications\Plex\Plex Media Server.exe', 'C:\ProgramData\Sonarr\bin\Sonarr.exe', 'D:\Applications\SABnzbd\SABnzbd.exe', 'D:\Applications\Tautulli\Tautulli.exe', 'D:\Applications\qBittorrent\qbittorrent.exe'
foreach ($app in $FilePathArray){
    if (ProcessValidator){
        Write-Output "`n`n$app has been started successfully!`n`n"
    } elseif (!ProcessValidator) {
        Write-Output "`n`n$app was already in a running state (did it not shutdown properly?)`n`n"
    } else {
        Write-Output "`n`nThere was an error, should we continue?"
        $ContinueInput = Read-Host -Prompt "Press Y|N key to continue"
        if ($ContinueInput -eq "Y"){
            continue
        } elseif ($ContinueInput -eq "N"){
            break
        } else {
            exit
        }
    }
}