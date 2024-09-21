#!/bin/bash

# Uvítací zpráva
# Base Install MariaDB, Appache2, PHP and utilities
echo "******************************************"
echo "  Vítejte v instalačním skriptu BIMAPu!    "
echo "******************************************"
echo "BIMAPu nainstaluje tyto balíčky na Raspberry Pi s Debianem:"
echo "- Git"
echo "- Composer"
echo "- Python3 a pip3"
echo "- Apache2"
echo "- Nejnovější PHP dostupné pro danou platformu."
echo "- MariaDB"
echo "- Správce databáze Adminer, ktery bude dostupný zadaním adresy http[s]://[ServerName]/adminer"
echo "- Firewall ufw se základními porty (21,22,80,443,3306,1883,5432,8883)."
echo "- Vytvoří 1GB swap soubor, pokud není operační systém na SD kartě."
echo "- Ve výchozí www složce vytvoří index.php a phpinfo.php."
echo "- Nastavení práv, skupin pro uživatele, složky a soubory je www-data."
echo "Pokud některý konfigurační soubor chybí, instalaci zrušíme."
echo "Připravte se na instalaci..."
echo " --------------------------------------"
echo ""

# Dotaz na pokračování
read -p "Chcete pokračovat v instalaci? (y/n): " choice
if [[ "$choice" != "y" ]]; then
    echo "Instalace byla zrušena."
    exit 0
fi

# Přidání repozitáře pro PHP 8.3
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

# Zjištění dostupné verze PHP
PHP_VERSION=$(apt-cache policy php | grep -m 1 'Candidate:' | awk '{print $2}' | cut -d ':' -f 2 | cut -d '+' -f 1 | cut -d '.' -f 1-2)

# Definice základních vstupních parametrů podle verze PHP
PACKAGES=( 
    curl 
    git 
    composer 
    python3-full
    python3-psutil
    python3-pip 
    apache2 
    php${PHP_VERSION} 
    php${PHP_VERSION}-fpm 
    php${PHP_VERSION}-mysql 
    php${PHP_VERSION}-xml 
    php${PHP_VERSION}-curl 
    php${PHP_VERSION}-mbstring 
    php${PHP_VERSION}-zip 
    php${PHP_VERSION}-gd 
    mariadb-server 
)

# Kontrola přítomnosti konfiguračních souborů
CONFIG_FILES=("config_git" "config_apache2" "config_php" "config_mariadb" "config_composer" "config_others")
missing_files=()

for config_file in "${CONFIG_FILES[@]}"; do
    if [[ ! -f "./$config_file" ]]; then
        missing_files+=("$config_file")
    fi
done

# Zpráva o chybějících souborech
if [ ${#missing_files[@]} -ne 0 ]; then
    echo "Následující konfigurační soubory chybí: ${missing_files[*]}"
    echo "Instalace byla zrušena."
    exit 1
fi

echo "Všechny konfigurační soubory jsou v pořádku. Pokračuji v instalaci..."

# Aktualizace balíčků
sudo apt-get update && sudo apt-get upgrade -y

# Instalace balíčků
sudo apt-get install -y "${PACKAGES[@]}"

# Spuštění konfiguračních skriptů
for config_file in "${CONFIG_FILES[@]}"; do
    bash ./"$config_file"
done

echo "Všechny balíčky byly úspěšně nainstalovány a konfigurace byla provedena."
