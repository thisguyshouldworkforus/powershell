# http://www.waynezim.com/2014/06/use-powershell-to-batch-convert-videos-using-handbrake/

$filelist = Get-ChildItem "C:\Users\alexa\Downloads\Reading Rainbow"
 
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
    Write-Host -------------------------------------------------------------------------------
    Write-Host Handbrake Batch Encoding
    Write-Host "Processing - $oldfile"
    Write-Host "File $i of $filecount - $progress%"
    Write-Host -------------------------------------------------------------------------------
     
    Start-Process "D:\Applications\HandBrake\HandBrakeCLI.exe" -ArgumentList "-Z `"H.264 MKV 1080p30`" -i `"$oldfile`" -o `"$newfile`" --verbose=0" -Wait -NoNewWindow
}
