<#
.SYNOPSIS
    alt4left (MightyTools) - Leworęczny układ polskich znaków (Ctrl+Alt -> AltGr) przez AutoHotkey.
.DESCRIPTION
    Interaktywny menedżer zarządzający instalacją AHK, konfiguracją układu alt4left,
    autostartem oraz całkowitą deinstalacją.
.AUTHOR
    MightyMich Tools
#>

# Wymuszenie kodowania UTF-8 w konsoli
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptName = "alt4left"
$startupDir = [Environment]::GetFolderPath('Startup')
$targetScriptPath = Join-Path $startupDir "$scriptName.ahk"

function Show-Menu {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "           alt4left (MightyTools) - MENEDŻER         " -ForegroundColor Yellow
    Write-Host "       Ergonomiczny układ Ctrl+Alt dla leworęcznych   " -ForegroundColor DarkCyan
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host " [1] Zainstaluj alt4left i dodaj do autostartu"
    Write-Host " [2] Uruchom alt4left tymczasowo na tę sesję"
    Write-Host " [3] Usuń alt4left z autostartu (wyłącz)"
    Write-Host " [4] Całkowicie odinstaluj alt4left oraz AutoHotkey"
    Write-Host " [5] Wyjście"
    Write-Host "======================================================" -ForegroundColor Cyan
}

function Create-AhkScript {
    $ahkContent = @"
; ======================================================
; alt4left v1.0 - MightyTools
; Leworęczny układ polskich znaków: Ctrl + Alt + litera
; ======================================================
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

<^<!z::
GetKeyState, state, Shift
if state = D
    Send, Ż
else
    Send, ż
return

<^<!c::
GetKeyState, state, Shift
if state = D
    Send, Ć
else
    Send, ć
return

<^<!e::
GetKeyState, state, Shift
if state = D
    Send, Ę
else
    Send, ę
return

<^<!a::
GetKeyState, state, Shift
if state = D
    Send, Ą
else
    Send, ą
return

<^<!s::
GetKeyState, state, Shift
if state = D
    Send, Ś
else
    Send, ś
return
"@
    Set-Content -Path $targetScriptPath -Value $ahkContent -Encoding UTF8
}

do {
    Show-Menu
    $choice = Read-Host "Wybierz opcję (1-5)"

    switch ($choice) {
        '1' {
            Write-Host "`n[*] Sprawdzanie i instalacja środowiska AutoHotkey przez winget..." -ForegroundColor Cyan
            winget install --id AutoHotkey.AutoHotkey -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            
            Write-Host "[*] Tworzenie skryptu alt4left i dodawanie do autostartu..." -ForegroundColor Cyan
            Create-AhkScript
            
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue
            Start-Process $targetScriptPath
            
            Write-Host "`n[+] Sukces! alt4left został zainstalowany i działa z systemem!" -ForegroundColor Green
            Pause
        }
        '2' {
            Write-Host "`n[*] Uruchamianie alt4left na bieżącą sesję..." -ForegroundColor Cyan
            winget install --id AutoHotkey.AutoHotkey -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            
            Create-AhkScript
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue
            Start-Process $targetScriptPath
            
            Write-Host "`n[+] alt4left został uruchomiony pomyślnie!" -ForegroundColor Green
            Pause
        }
        '3' {
            Write-Host "`n[*] Usuwanie alt4left z autostartu..." -ForegroundColor Yellow
            if (Test-Path $targetScriptPath) {
                Remove-Item $targetScriptPath -Force
                Write-Host "[+] Usunięto alt4left z autostartu." -ForegroundColor Green
            } else {
                Write-Host "[i] alt4left nie był obecny w autostarcie." -ForegroundColor Yellow
            }
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue
            Write-Host "[+] Wyłączono działające procesy AHK." -ForegroundColor Green
            Pause
        }
        '4' {
            Write-Host "`n[*] Rozpoczynanie całkowitej deinstalacji alt4left..." -ForegroundColor Yellow
            if (Test-Path $targetScriptPath) {
                Remove-Item $targetScriptPath -Force
            }
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue

            Write-Host "[*] Odinstalowywanie AutoHotkey z systemu..." -ForegroundColor Cyan
            winget uninstall --id AutoHotkey.AutoHotkey --silent | Out-Null

            Write-Host "[+] alt4left i silnik AHK zostały całkowicie usunięte!" -ForegroundColor Cyan
            Pause
        }
        '5' {
            Write-Host "`nZamykanie menedżera alt4left. Trzymaj się!" -ForegroundColor Cyan
            exit
        }
        default {
            Write-Host "`n[-] Nie wybrano poprawnej opcji. Spróbuj ponownie." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($true)
