#
# UnpackCab.ps1
#
param(
  [String]$filePath = "C:\Users\ulyanov\Desktop\bld\Layouts.cab"
 )

 $dir = Split-Path -Path $filePath     
 Write-Host $dir
 Set-Location $dir

 $cabFile = [System.IO.Path]::GetFileName($filePath)
 Write-Host  $cabFile

 $epath = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
 Write-Host  $epath

 $fepath = Join-Path -Path $dir -ChildPath $epath
 Write-Host $fepath

 New-Item -ItemType Directory -Force -Path $fepath
 Remove-Item $fepath\* -Force

 expand $cabFile -F:*.* $epath;