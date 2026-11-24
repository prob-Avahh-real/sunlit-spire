#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "☀️  晴光碑谷 · App Builder"
export JAVA_HOME="${JAVA_HOME:-/opt/homebrew/Cellar/openjdk@17/17.0.19/libexec/openjdk.jdk/Contents/Home}"
if [ ! -d "$JAVA_HOME" ]; then
  JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null || true)"
fi
export ANDROID_HOME="${ANDROID_HOME:-$HOME/Library/Android/sdk}"
export PATH="/opt/homebrew/bin:$JAVA_HOME/bin:$PATH"
[ ! -d node_modules ] && npm install
mkdir -p www
cp -f index.html www/index.html
node scripts/build-web.js
[ ! -d ios ] && npx cap add ios 2>/dev/null || true
[ ! -d android ] && npx cap add android
npx cap sync
cd android
echo -e "org.gradle.jvmargs=-Xmx2048m\nandroid.useAndroidX=true" > gradle.properties
./gradlew assembleDebug 2>&1 | tail -5
echo "📦 APK: android/app/build/outputs/apk/debug/app-debug.apk"
