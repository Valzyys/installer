#!/bin/bash

# Cek apakah Node.js sudah terinstal
if ! command -v node &> /dev/null
then
    echo "⚠️ Node.js tidak ditemukan. Menginstal Node.js..."
    
    # Instal Node.js (untuk Debian/Ubuntu)
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
fi

# Cek apakah npm sudah terinstal
if ! command -v npm &> /dev/null
then
    echo "⚠️ npm tidak ditemukan. Menginstal npm..."
    sudo apt install -y npm
fi

# Clone repository jika belum ada
if [ ! -d "api-jkt48connect" ]; then
    echo "📥 Mengunduh repository..."
    git clone https://github.com/USERNAME/api-jkt48connect.git
fi

cd api-jkt48connect

# Instal dependensi
echo "📦 Menginstal dependensi..."
npm install

# Jalankan aplikasi
echo "🚀 Menjalankan aplikasi..."
node .
