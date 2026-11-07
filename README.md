# alt4left (MightyMich Tools)

> **Ergonomiczny układ polskich znaków dla leworęcznych (Lewy Ctrl + Lewy Alt = AltGr)**

[![Platforma Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com)
[![AutoHotkey](https://img.shields.io/badge/Engine-AutoHotkey_v1-green.svg)](https://www.autohotkey.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📌 O projekcie

**alt4left** to lekkie, szybkie i bezobsługowe narzędzie stworzone z myślą o użytkownikach leworęcznych, którzy piszą na standardowych klawiszach i potrzebują wygodnego dostępu do polskich znaków diakrytycznych (`ą`, `ć`, `ę`, `ł`, `ń`, `ó`, `ś`, `ź`, `ż`) przy użyciu lewej ręki.

W standardowym układzie systemowym polskie litery aktywowane są kombinacją `Prawy Alt + litera`. Dla osób operujących myszką prawą ręką i piszących lewą ręką, lub po prostu preferujących układ pod lewą dłoń, natywne rozwiązanie bywa niewygodne – zwłaszcza w aplikacjach takich jak Microsoft Word czy pakiety biurowe, gdzie kombinacje z lewym `Ctrl + Alt` często wchodzą w konflikty ze skrótami systemowymi. **alt4left** rozwiązuje ten problem raz na zawsze na poziomie systemu operacyjnego.

---

## ⚡ Główne funkcje

* **Ergonomia dla leworęcznych:** Zamienia kombinację **Lewy Ctrl + Lewy Alt + Litera** na precyzyjny sygnał polskich znaków.
* **Pełna kompatybilność z Office:** Działa bez zacięć w pakiecie Microsoft Word, omijając wewnętrzne blokady i konflikty wstążki.
* **Menedżer PowerShell:** Interaktywny skrypt instalacyjny pozwala na automatyczne pobranie środowiska, konfigurację autostartu oraz czyste usunięcie.
* **Zero obciążenia:** Bazuje na sprawdzonym i zoptymalizowanym silniku AutoHotkey działającym w tle.

---

## 🚀 Szybka instalacja (PowerShell)

Możesz zainstalować lub zarządzać narzędziem za pomocą interaktywnego skryptu PowerShell. Uruchom program PowerShell **jako Administrator** i wybierz odpowiednią opcję w menu.

Możesz też pobrać plik `alt4left.ps1` z repozytorium i uruchomić go lokalnie:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\alt4left.ps1
