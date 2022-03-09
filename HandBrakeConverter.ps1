function Write-Log {
    Param(
        $Message,
        $Path = "$env:LOGS_DIR\HandBrakeCLI.txt"
    )

    function TS {Get-Date -Format 'hh:mm:ss'}
    "[$(TS)]$Message" | Tee-Object -FilePath $Path -Append | Write-Verbose
}

$filelist = Get-ChildItem "C:\Users\alexa\Downloads\ReadingRainbow"
 
$num = $filelist | Measure-Object
$filecount = $num.count
 
$i = 0;
ForEach ($file in $filelist)
{
    $i++;
    $oldfile = $file.DirectoryName + "\" + $file.BaseName + $file.Extension;
    $newfile = "P:\tv.kids\Reading.Rainbow" + "\" + $file.BaseName + ".mkv";
      
    $progress = ($i / $filecount) * 100
    $progress = [Math]::Round($progress,2)
 
    Clear-Host
    Write-Host "`n`n"
    Write-Host -BackgroundColor White -ForegroundColor DarkGray "-------------------------------------------------------------------------------"
    Write-Host -BackgroundColor White -ForegroundColor DarkGray "    Handbrake Batch Encoding                                                   "
    Write-Host -BackgroundColor White -ForegroundColor DarkGray "    Processing: `"$oldfile`"           "
    Write-Host -BackgroundColor White -ForegroundColor DarkGray "-------------------------------------------------------------------------------"
    Write-Host "`n`n"

    Start-Process "D:\Applications\HandBrake\HandBrakeCLI.exe" -ArgumentList "-Z `"H.264 MKV 1080p30`" -i `"$oldfile`" -o `"$newfile`" --verbose=0" -Wait -NoNewWindow | Write-Log
}

Write-Progress -Activity "Encoding in progress ... " -Status "$progress% Complete" -PercentComplete $progress