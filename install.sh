#!/bin/bash

echo "🔄 Memeriksa sistem..."
OS=$(uname -o)

# Cek apakah sistem adalah Termux
if [[ "$OS" == "Android" ]]; then
    echo "📲 Detected Termux!"
    PKG_INSTALL="pkg install -y"
else
    echo "💻 Detected Linux!"
    PKG_INSTALL="sudo apt install -y"
fi

# Periksa apakah Node.js sudah terinstal
if ! command -v node &> /dev/null
then
    echo "⚠️ Node.js tidak ditemukan. Menginstal Node.js..."
    
    if [[ "$OS" == "Android" ]]; then
        pkg install nodejs -y
    else
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt install -y nodejs
    fi
fi

# Periksa apakah Git sudah terinstal
if ! command -v git &> /dev/null
then
    echo "⚠️ Git tidak ditemukan. Menginstal Git..."
    $PKG_INSTALL git
fi

# Periksa apakah npm sudah terinstal
if ! command -v npm &> /dev/null
then
    echo "⚠️ npm tidak ditemukan. Menginstal npm..."
    $PKG_INSTALL npm
fi

# Clone repository jika belum ada
if [ ! -d "api-jkt48connect" ]; then
    echo "📥 Mengunduh repository..."
    git clone https://github.com/USERNAME/api-jkt48connect.git
fi

# Masuk ke dalam folder proyek
cd api-jkt48connect

# Instal dependensi
echo "📦 Menginstal dependensi..."
npm install

# Jalankan aplikasi
echo "🚀 Menjalankan aplikasi..."
node .
