# Adapted from:
# https://github.com/skycommand/AdminScripts/blob/master/AppX/Remove%20notorious%20AppX%20packages.ps1

#Requires -RunAsAdministrator
Import-Module -Name Appx -ErrorAction Stop

# Only run if the PowerShell Version is less than 7
Select-Object -InputObject $PSVersionTable > "$env:HOMEPATH\psversiontable.txt"
Get-Content -Path "$env:HOMEPATH\psversiontable.txt" | Where-Object{$_ -match 'PSVersion'} > "$env:HOMEPATH\psversion.txt"
$versionInfo = Get-Content -Path "$env:HOMEPATH\psversion.txt"
if ($versionInfo -match '^(PSVersion)(\s+)([3456]{1})(\.)(\d+)(\.)(\d+)(\.)(\d+)'){
    Write-Host "PowerShell Version" $Matches[3]
    Remove-Item -Path "$env:HOMEPATH\psversion*"
    } else {
        Write-Error "The APPX PowerShell Module is too buggy in version 7! Quitting ...."
        Remove-Item -Path "$env:HOMEPATH\psversion*"
        Exit-PSSession
}

$applist = @(
  "Microsoft.3DBuilder",                             # 3D Builder
  "Microsoft.DesktopAppInstaller",                   # App Installer
  "Microsoft.GetHelp",                               # Get Help
  "Microsoft.Getstarted",                            # Tips
  "Microsoft.Messaging",                             # Messaging
  "Microsoft.Microsoft3DViewer",                     # 3D Viewer (formerly Mixed Reality Viewer, View 3D)
  "Microsoft.MicrosoftOfficeHub",                    # My Office
  "Microsoft.MicrosoftSolitaireCollection",          # Solitaire Collection
  "Microsoft.MixedReality.Portal",                   # Mixed Reality Portal
  "Microsoft.MSPaint",                               # Paint 3D
  "Microsoft.Office.OneNote",                        # OneNote (the pathetic remake, not the original)
  "Microsoft.OneConnect",                            # Paid Wi-Fi & Cellular
  "Microsoft.Print3D",                               # Print 3D
  "Windows.Print3D",                                 # Print 3D backend
  "Microsoft.StorePurchaseApp",                      # Store Purchase App
  "Microsoft.Wallet",                                # Pay
  "Microsoft.WindowsFeedbackHub",                    # Feedback Hub
  "Microsoft.WindowsSoundRecorder",                  # Voice Recorder
  "Microsoft.Xbox.TCUI",                             # Xbox Live in-game experience
  "Microsoft.XboxApp",                               # Xbox Console Companion (formerly Xbox)
  "Microsoft.XboxGameOverlay",                       # Xbox Game Bar Plug-in
  "Microsoft.XboxGamingOverlay",                     # Xbox Game Bar
  "Microsoft.XboxIdentityProvider",                  # Xbox Identity Provider
  "Microsoft.XboxSpeechToTextOverlay",               # ???
  "Microsoft.YourPhone",                             # Your Phone
  "Microsoft.ZuneMusic",                             # Groove
  "Microsoft.ZuneVideo",                             # Movies & TV
  "Windows.ContactSupport",                          # Contact Support
  "ActiproSoftwareLLC.562882FEEB491",                # Code Writer
  "46928bounde.EclipseManager",                      # Eclipse Manager
  "PandoraMediaInc.29680B314EFC2",                   # Pandora
  "AdobeSystemsIncorporated.AdobePhotoshopExpress",  # Adobe Photoshop Express
  "D5EA27B7.Duolingo-LearnLanguagesforFree",         # Duolingo
  "Microsoft.NetworkSpeedTest",                      # Network Speed Test
  "Microsoft.BingNews",                              # Bing News
  "Microsoft.Office.Sway"                            # Office Sway
)

foreach ($app in $applist) {
  Write-Output $("Looking for {0}" -f $app)
  $APPXs = Get-AppxPackage $app -AllUsers
  if ($null -ne $APPXs )
  {
    foreach ($APPX in $APPXs) {
      Write-Output $("Removing {0}" -f $APPX.ToString())
      Remove-AppxPackage -AllUsers -Package $APPX
    }
    Remove-Variable APPX
  } else {
    Write-Output $("{0} is not installed." -f $app)
  }
  Write-Output ""
}
