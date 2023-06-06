#########################################
#Script Name   : Compressor_Files

#Author        : Alexandre Simões © 2023 

#Data          : 06-06-2023
#########################################

### Variables ###

$source = "C:\Users\"

cd $source

$listing = 'dir'

Invoke-Expression "$listing | Format-Table Mode,LastWriteTime,Name"

$destination = Read-Host "`nSelecionar o diretório pretendido"

cd ".\$destination"

Invoke-Expression "$listing | select BaseName | Format-Table BaseName"

$dest2 = Read-Host "`nSelecionar o diretório pretendido"

cd ".\$dest2"

Invoke-Expression "$listing | select Extension,BaseName | Format-Table Extension,BaseName"

#$verification = Read-Host "`nTodos os diretorios selecinados [s|n]"

$files = Read-Host "`nQual a extensao de ficheiro que pretende selecionar"

$filesChoice = "$listing *.$files | select BaseName,Extension | Format-Table Extension, BaseName"

Invoke-Expression $filesChoice

$truth = "s"

$negative = "n"

### Compressão Ficheiros ###

$compressor = & "C:\Program Files\7-Zip\7z.exe" a -tzip archive_bck_$files.zip *.$files

Write-Host -ForegroundColor Green "`nFicheiro comprimido e movido para a pasta $folder"

### Criação + Verificação da Pasta para apagar ficheiros ###
  
$foldErase = "Files_To_Delete"
  
if(-Not(Test-Path $foldErase))
{
  mkdir $foldErase
  Move-Item -Path .\*.$files -Destination $foldErase
  Write-Host -ForegroundColor Yellow "`nValidar ficheiro(s) na pasta $foldErase"
  #Write-Host -ForegroundColor Red "`nPasta $foldErase existente! Escolher outro nome..."
  #$EraserFold = Read-Host "`nNome da pasta dos ficheiros a apagar"
  #mkdir $EraserFold
  #Move-Item -Path .\*.$files -Destination $EraserFold
}else
{
  Write-Host -ForegroundColor Red "`nNao e possivel selecionar o diretorio pretendido!"
  exit
}