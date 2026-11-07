# alt4left (MightyMich Tools)

> **Ergonomiczny układ polskich znaków dla leworęcznych (Lewy Ctrl + Lewy Alt = AltGr)**

[![Platforma Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)](https://www.microsoft.com)
[![AutoHotkey](https://img.shields.io/badge/Engine-AutoHotkey_v1-green.svg)](https://www.autohotkey.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📌 O projekcie

**alt4left** to lekkie, szybkie i bezobsługowe narzędzie stworzone z myślą o użytkownikach leworęcznych, którzy piszą na standardowych klawiszach i potrzebują wygodnego dostępu do polskich znaków diakrytycznych (`ą`, `ć`, `ę`, `ł`, `ń`, `ó`, `ś`, `ź`, `ż`) przy użyciu lewej ręki.

W standardowym układzie systemowym polskie litery aktywowane są kombinacją `Prawy Alt + litera`. Dla osób operujących myszką prawą ręką i piszących lewą ręką, natywne rozwiązanie bywa niewygodne – zwłaszcza w aplikacjach takich jak Microsoft Word, gdzie kombinacje z lewym `Ctrl + Alt` często wchodzą w konflikty ze skrótami systemowymi. **alt4left** rozwiązuje ten problem raz na zawsze na poziomie systemu operacyjnego.

---

## ⚡ Główne funkcje

* **Ergonomia dla leworęcznych:** Zamienia kombinację **Lewy Ctrl + Lewy Alt + Litera** na precyzyjny sygnał polskich znaków.
* **Pełna kompatybilność z Office:** Działa bez zacięć w pakiecie Microsoft Word, omijając wewnętrzne blokady i konflikty wstążki.
* **Interaktywny menedżer PowerShell:** Pozwala na automatyczne pobranie środowiska, konfigurację autostartu, uruchamianie tymczasowe oraz czyste usunięcie.
* **Zero obciążenia:** Bazuje na sprawdzonym i zoptymalizowanym silniku AutoHotkey działającym w tle.

---

## 🚀 Błyskawiczna instalacja (One-Liner przez `iex`)

Możesz wdrożyć i uruchomić menedżer **alt4left** bezpośrednio z poziomu programu PowerShell za pomocą jednej komendy:

```powershell
irm https://raw.githubusercontent.com/mich111discord/alt4left-PL/refs/heads/main/install.ps1 | iex
