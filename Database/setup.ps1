<#
.SYNOPSIS
  Cree (ou recree) les trois bases du projet sur une instance SQL Server locale.

.EXAMPLE
  .\Database\setup.ps1 -Server ".\SQLEXPRESS"
  .\Database\setup.ps1 -Server ".\SQLEXPRESS" -Reset     # supprime d'abord les trois bases
#>
param(
    [string]$Server = ".\SQLEXPRESS",
    [switch]$Reset
)

$ErrorActionPreference = "Stop"
$here = $PSScriptRoot

function Invoke-Sql([string]$File) {
    Write-Host "  -> $(Split-Path $File -Leaf)"
    # -f 65001 : les scripts sont en UTF-8 (accents dans les noms de provinces)
    sqlcmd -S $Server -E -C -b -f 65001 -i $File
    if ($LASTEXITCODE -ne 0) { throw "Echec : $File" }
}

if ($Reset) {
    Write-Host "Suppression des bases existantes..."
    foreach ($db in "TemperatureDB", "PrecipitationDB", "PollutionDB") {
        $query = "IF DB_ID('$db') IS NOT NULL BEGIN ALTER DATABASE $db SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE $db; END"
        sqlcmd -S $Server -E -C -b -Q $query
        if ($LASTEXITCODE -ne 0) { throw "Impossible de supprimer $db" }
    }
}

Write-Host "Creation des tables et chargement des donnees..."
foreach ($db in "TemperatureDB", "PrecipitationDB", "PollutionDB") {
    Get-ChildItem "$here\$db" -Filter "*.sql" | Sort-Object Name | ForEach-Object { Invoke-Sql $_.FullName }
}

Write-Host "Procedures stockees, declencheurs et vues..."
Invoke-Sql "$here\Procedures\stored_procedures.sql"
Invoke-Sql "$here\Triggers\triggers.sql"
Invoke-Sql "$here\Views\create_views.sql"

Write-Host "Termine."
