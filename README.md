# BIMAPu - *Base Install MariaDB, Apache2, PHP and utilities*

## Popis
BIMAPu nainstaluje tyto balíčky na Raspberry Pi s Debianem:
- [Git](https://git-scm.com/download/linux)
- Composer
- Python 3 a pip3
- Apache2
- Nejnovější PHP dostupné pro danou platformu
- MariaDB
- Správce databáze [Adminer](https://www.adminer.org/cs/), který bude dostupný na http[s]://[ServerName]/adminer
- Firewall UFW se základními porty (21, 22, 80, 443, 3306, 1883, 5432, 8883)
- Vytvoří 1GB swap soubor, pokud systém neběží z SD karty.
- Ve výchozí www složce vytvoří index.php a phpinfo.php.
- Nastavení práv, skupin pro uživatele, složky a soubory je www-data.


## Spuštění skriptu

1. Otevřete terminál.
   
2. Přidejte spustitelná práva skriptu:
   ```bash
   sudo chmod +x install.sh
   ```
3. Spusťte skript pomocí bash:
   ```bash
   sudo ./install.sh
   ```
4. Postupujte podle instrukcí instalace.
5. Enjoy!
