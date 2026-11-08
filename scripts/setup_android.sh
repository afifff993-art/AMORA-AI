#!/usr/bin/env bash
# Generates the Android Gradle project for the Flutter app (only if missing)
# and sets the app name to AMORA. Safe to run many times.
set -euo pipefail
cd "$(dirname "$0")/../frontend"

if [ ! -d android ]; then
  echo "Generating Android project with flutter create..."
  flutter create --platforms=android --project-name amora --org com.isagi.amora .
else
  echo "android/ already exists - keeping it."
fi

MANIFEST="android/app/src/main/AndroidManifest.xml"
if grep -q 'android:label="amora"' "$MANIFEST"; then
  sed -i 's/android:label="amora"/android:label="AMORA"/' "$MANIFEST"
  echo "App label set to AMORA."
fi
