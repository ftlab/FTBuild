#
# PackCab.ps1
#
param(
  [String]$filePath = "C:\develop\FCOD\CENSOR\dev\Tools\Starter\Layouts"
, [String]$path = "C:\Users\ulyanov\Desktop\bld"
, [String]$cabName = "Layouts")
     
 Write-Host $filePath;

 $ddfFile = Join-Path -path $filePath -childpath temp.ddf
 $ddfHeader = @"
;*** MakeCAB Directive file
;
.OPTION EXPLICIT      
.Set CabinetNameTemplate=$cabName.cab
.set DiskDirectory1=$path
.Set MaxDiskSize=CDROM
.Set Cabinet=on
.Set Compress=on
.Set UniqueFiles=on
"@

$ddfHeader | Out-File -filepath $ddfFile -Force -encoding default
 
 Get-ChildItem -Path $filePath -Exclude *.cs, *.ddf |
 Where-Object { !$_.psiscontainer } |
 ForEach-Object{
     Write-Host "File:" $_.FullName
     '"' + $_.FullName + '"' | Out-File -filepath $ddfFile -encoding default -append
 }

 Get-ChildItem -Path $filePath -Recurse |
 Where-Object { $_.psiscontainer } |
 ForEach-Object{
    Write-Host "Dir:" $_.FullName
    '.Set DestinationDir="' + $_.FullName.Replace($filePath, "").TrimStart("\\") + '"' |
     Out-File -filepath $ddfFile -encoding default -append
    
    Get-ChildItem -Path $_.FullName -Exclude *.cs, *.ddf |
    Where-Object { !$_.psiscontainer } |
    ForEach-Object{
        Write-Host "File:" $_.FullName
        '"' + $_.FullName + '"' | Out-File -filepath $ddfFile -encoding default -append
    }
 } 

 makecab /f $ddfFile /V3