#!/bin/bash

echo "🔄 Memeriksa sistem..."
OS=$(uname -o)

# Cek apakah sistem adalah Termux atau Linux
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

# Periksa apakah npm sudah terinstal
if ! command -v npm &> /dev/null
then
    echo "⚠️ npm tidak ditemukan. Menginstal npm..."
    $PKG_INSTALL npm
fi

# Buat folder project jika belum ada
if [ ! -d "jkt48connect-bot" ]; then
    echo "📁 Membuat folder proyek..."
    mkdir jkt48connect-bot
fi

# Masuk ke folder project
cd jkt48connect-bot

# Inisialisasi proyek jika belum ada package.json
if [ ! -f "package.json" ]; then
    echo "📜 Menginisialisasi proyek Node.js..."
    npm init -y
fi

# Instal modul api-jkt48connect
echo "📦 Menginstal api-jkt48connect..."
npm install api-jkt48connect

# Buat file index.js jika belum ada
if [ ! -f "index.js" ]; then
    echo "📝 Membuat file index.js..."
    cat <<EOF > index.js
const jkt48connect = require("api-jkt48connect");

async function checkLive() {
    try {
        const live = await jkt48connect.getLive("API_KEY_ANDA");
        console.log("🎥 Live Member JKT48 Saat Ini:", live);
    } catch (err) {
        console.error("❌ Gagal mengambil data live:", err.message);
    }
}

// Jalankan pengecekan live
checkLive();
EOF
fi

echo "🚀 Menjalankan aplikasi..."
node index.js
