# shell.nix
{ pkgs ? import <nixpkgs> {} }:

let
  flutter = pkgs.flutterPackages.latest;
  node = pkgs.nodejs-18_x;
in
pkgs.mkShell {
  buildInputs = [
    flutter
    node
    pkgs.git
    pkgs.curl
    pkgs.unzip
  ];

  shellHook = ''
    echo "Setting up Flutter and Node.js environment..."
    export PATH="$PATH:${flutter}/bin"

    if [ ! -d "tiktok_clone" ]; then
      echo "Creating Flutter project..."
      flutter create tiktok_clone
      cd tiktok_clone
      echo "Adding Firebase dependencies..."
      cat <<EOL >> pubspec.yaml
dependencies:
  firebase_core: ^2.3.0
  firebase_auth: ^4.0.0
  cloud_firestore: ^4.0.0
  video_player: ^2.4.2
EOL
      flutter pub get
      cd ..
    else
      echo "Flutter project already exists."
    fi

    if [ ! -d "backend" ]; then
      echo "Setting up Node.js backend..."
      mkdir -p backend
      cd backend
      npm init -y
      npm install express firebase-admin body-parser
      cat <<EOL > server.js
const express = require('express');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.applicationDefault()
});

const app = express();
app.use(bodyParser.json());

app.post('/uploadVideo', async (req, res) => {
  // Handle video upload and processing
  res.send('Video uploaded');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
EOL
      cd ..
    else
      echo "Backend already set up."
    fi
  '';
}