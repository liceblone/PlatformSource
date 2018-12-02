##############################################################################################
##
##  This script is for creating B1 installation  packages 
##
##  usage: 
##      -ProjectName BI.Solution.Setup.sln -ProductVersion 3.5.0.1 -PublishDir E:\Integration\HRCM.Trunk\Packages\BI\
##
##  build by msbuild:    
##      C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe   BI.Solution.Setup.sln    /p:ProductVersion=3.4.0.0  
##
##############################################################################################


param($ProjectName , $ProductVersion, $PublishDir )
cls
$PublishDir = $PublishDir + $ProductVersion+"\"
$ScriptDir = split-path -parent $MyInvocation.MyCommand.Definition
$PackageDir = $ScriptDir + "\BI.Setup\bin\Release\en-us\"

Write-Host $ProjectName

Write-Host $ProductVersion
Write-Host $PublishDir
Write-Host $PackageDir

function FixDTSXVersionNumber($BIPath, $BuildNo)
{
    #[String]$File2008 = "E:\Integration\HRCM.Trunk\BI\HVI-HRM-B1\ETL\2008\HRCMBISSIS\CDNHosp_ETL.dtsx"    

    [String]$File2008 = $BIPath + "HVI-HRM-B1\ETL\2008\HRCMBISSIS\CDNHosp_ETL.dtsx"
    [String]$File2012 = $BIPath + "HVI-HRM-B1\ETL\2012\HRCMBISSIS\CDNHosp_ETL.dtsx"

    write-host  $BuildNo
    write-host  $File2008
    
    # update <DTS:Property DTS:Name="VersionComments">Build No</DTS:Property>
    [xml]$Root = Get-Content $File2008
    $versionCommentsNode = $Root.Executable.Property | where {$_.Name -eq 'VersionComments'}
	$versionCommentsNode.InnerText = $BuildNo
    $Root.Save( $File2008 )

    # set DTS:VersionComments to build no
    $Root = Get-Content $File2012
    $Root.Executable.VersionComments = $BuildNo

    $Root.Save( $File2012 )

    write-host  "BI Build Number has been changed to "$BuildNo
}

################################################################Clear Folder
if (Test-Path  ("BI.Setup\bin\Release\" ))
{
    Remove-Item "BI.Setup\bin\Release\*" -recurse   -force
}


################################################################ fix the build number in *.dtsx
FixDTSXVersionNumber $ScriptDir"\..\..\"  $ProductVersion


################################################################create Installaion package
write-host "creating Installation package"
C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe $ProjectName  /p:Configuration=release /t:rebuild /p:ProductVersion=$ProductVersion 
write-host "Installation package created successfully"


################################################################create publish folder
if (!(Test-Path -path $PublishDir))
{
 	new-item -Path  $PublishDir -ItemType directory
}


################################################################Copy package to publish dir
Write-Host "Copy package to publish dir"
Remove-Item $PublishDir"*.*"   -recurse -force	
Copy-Item   $PackageDir"*"      $PublishDir     -recurse -force	

write-host "BI Installation package copy to publish folder successfully"

