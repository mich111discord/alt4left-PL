<#
.SYNOPSIS
    alt4left (MightyTools) - Menedżer leworęcznego układu i modyfikacji klawiatury.
.DESCRIPTION
    Pobiera i zarządza skryptem alt4left.ahk bezpośrednio z repozytorium GitHub,
    obsługuje autostart, aktualizacje po wersji z nagłówka oraz deinstalację.
.AUTHOR
    MightyTools
#>

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$scriptName = "alt4left"
$startupDir = [Environment]::GetFolderPath('Startup')
$targetScriptPath = Join-Path $startupDir "$scriptName.ahk"
$remoteAhkUrl = "https://raw.githubusercontent.com/mich111discord/alt4left-PL/refs/heads/main/alt4left.ahk"

function Get-ScriptVersion {
    param ([string]$Path)
    if (-not (Test-Path $Path)) { return $null }
    $firstLine = Get-Content -Path $Path -TotalCount 1
    if ($firstLine -match "version=([0-9\.]+)`$") {
        return $Matches[1]
    }
    return "1.0.0" # Domyślna jeśli brak tagu
}

function Show-Menu {
    Clear-Host
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host "          alt4left (MightyTools) - MENEDŻER           " -ForegroundColor Yellow
    Write-Host "    Ergonomiczny układ Ctrl+Alt + Shift Swap          " -ForegroundColor DarkCyan
    Write-Host "======================================================" -ForegroundColor Cyan
    Write-Host " [1] Zainstaluj / Zaktualizuj alt4left (z autostartem)"
    Write-Host " [2] Sprawdź dostępność aktualizacji"
    Write-Host " [3] Uruchom alt4left tymczasowo na tę sesję"
    Write-Host " [4] Usuń alt4left z autostartu (wyłącz)"
    Write-Host " [5] Całkowicie odinstaluj alt4left oraz AutoHotkey"
    Write-Host " [6] Wyjście"
    Write-Host "======================================================" -ForegroundColor Cyan
}

do {
    Show-Menu
    $choice = Read-Host "Wybierz opcję (1-6)"

    switch ($choice) {
        '1' {
            Write-Host "`n[*] Sprawdzanie i instalacja środowiska AutoHotkey przez winget..." -ForegroundColor Cyan
            winget install --id AutoHotkey.AutoHotkey -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            
            Write-Host "[*] Pobieranie najnowszego skryptu alt4left.ahk z repozytorium..." -ForegroundColor Cyan
            try {
                Invoke-WebRequest -Uri $remoteAhkUrl -OutFile $targetScriptPath -UseBasicParsing
                Write-Host "[+] Pobrano pomyślnie do autostartu: $targetScriptPath" -ForegroundColor Green
            } catch {
                Write-Host "[-] Błąd podczas pobierania pliku AHK: $_" -ForegroundColor Red
                Pause
                continue
            }
            
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue
            Start-Process $targetScriptPath
            
            Write-Host "`n[+] Sukces! alt4left został zainstalowany, zaktualizowany i uruchomiony!" -ForegroundColor Green
            Pause
        }
        '2' {
            Write-Host "`n[*] Sprawdzanie aktualizacji..." -ForegroundColor Cyan
            if (-not (Test-Path $targetScriptPath)) {
                Write-Host "[!] alt4left nie jest zainstalowany w autostarcie." -ForegroundColor Yellow
                Pause
                continue
            }

            $localVersion = Get-ScriptVersion -Path $targetScriptPath
            Write-Host "[i] Lokalna wersja: $localVersion" -ForegroundColor Gray

            try {
                $tempRemotePath = "$env:TEMP\alt4left_remote_check.ahk"
                Invoke-WebRequest -Uri $remoteAhkUrl -OutFile $tempRemotePath -UseBasicParsing -ErrorAction Stop
                $remoteVersion = Get-ScriptVersion -Path $tempRemotePath
                Remove-Item $tempRemotePath -Force -ErrorAction SilentlyContinue

                Write-Host "[i] Zdalna wersja:  $remoteVersion" -ForegroundColor Gray

                if ([version]$remoteVersion -gt [version]$localVersion) {
                    Write-Host "`n[!] Dostępna jest nowa wersja ($remoteVersion)! Wybierz opcję [1] aby zaktualizować." -ForegroundColor Yellow
                } else {
                    Write-Host "`n[+] Masz najnowszą wersję skryptu alt4left." -ForegroundColor Green
                }
            } catch {
                Write-Host "[-] Nie udało się sprawdzić wersji zdalnej: $_" -ForegroundColor Red
            }
            Pause
        }
        '3' {
            Write-Host "`n[*] Uruchamianie alt4left tymczasowo..." -ForegroundColor Cyan
            winget install --id AutoHotkey.AutoHotkey -e --silent --accept-package-agreements --accept-source-agreements | Out-Null
            
            $tempScriptPath = "$env:TEMP\alt4left_temp.ahk"
            try {
                Invoke-WebRequest -Uri $remoteAhkUrl -OutFile $tempScriptPath -UseBasicParsing
                Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue
                Start-Process $tempScriptPath
                Write-Host "`n[+] alt4left został uruchomiony tymczasowo na tę sesję!" -ForegroundColor Green
            } catch {
                Write-Host "[-] Błąd pobierania skryptu: $_" -ForegroundColor Red
            }
            Pause
        }
        '4' {
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
        '5' {
            Write-Host "`n[*] Rozpoczynanie całkowitej deinstalacji alt4left..." -ForegroundColor Yellow
            if (Test-Path $targetScriptPath) {
                Remove-Item $targetScriptPath -Force
            }
            Stop-Process -Name "AutoHotkey" -ErrorAction SilentlyContinue

            Write-Host "[*] Odinstalowywanie AutoHotkey z systemu..." -ForegroundColor Cyan
            winget uninstall --id AutoHotkey.AutoHotkey --silent | Out-Null

            Write-Host "[+] alt4left i silnik AHK zostały całkowicie usunięte z systemu!" -ForegroundColor Cyan
            Pause
        }
        '6' {
            Write-Host "`nZamykanie menedżera alt4left. Trzymaj się!" -ForegroundColor Cyan
            exit
        }
        default {
            Write-Host "`n[-] Nie wybrano poprawnej opcji. Spróbuj ponownie." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($true)
