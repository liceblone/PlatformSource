$filepath = $args[0]
Set-Location -Path "$filepath"
$CreateScript = ".\DBCustomAction\SQLScript\CreateStructure.sql"
$DataMartVersion = Get-Content (".\DBCustomAction\DataMartVersion.txt")
Clear-Content $CreateScript


Add-Content $CreateScript -Value "Use `$(DATABASE_NAME) "
Add-Content $CreateScript -Value "GO "
Add-Content $CreateScript -Value ""

Add-Content $CreateScript -Value "EXEC sys.sp_addextendedproperty"
Add-Content $CreateScript -Value "@name = N'DataMartVersion',"
Add-Content $CreateScript -Value ("@value = N'" + $DataMartVersion + "';")
foreach ($file in (Get-ChildItem -Path "..\Database\Programmability"))
{
	$ScriptFileContent = Get-Content -Path $file.FullName	
	$ScriptFileContent = $ScriptFileContent -replace "'", "''"
	Add-Content -Path $CreateScript -Value "execute('"
	Add-Content -Path $CreateScript -Value $ScriptFileContent
	Add-Content -Path $CreateScript -Value "')"
}
foreach ($file in (Get-ChildItem -Path "..\Database\Tables"))
{
	$ScriptFileContent = Get-Content -Path $file.FullName	
	Add-Content -Path $CreateScript -Value "execute('"
	Add-Content -Path $CreateScript -Value $ScriptFileContent
	Add-Content -Path $CreateScript -Value "')"
}
foreach ($file in (Get-ChildItem -Path "..\Database\Views"))
{
	$ScriptFileContent = Get-Content -Path $file.FullName
	$ScriptFileContent = $ScriptFileContent -replace "'", "''"
	Add-Content -Path $CreateScript -Value "execute('"
	Add-Content -Path $CreateScript -Value $ScriptFileContent
	Add-Content -Path $CreateScript -Value "')"
}
Add-Content -Path $CreateScript -Value "execute('"
Add-Content $CreateScript -Value ("insert into dbo.version (version) values(''" + $DataMartVersion + "'');")
Add-Content -Path $CreateScript -Value "')"