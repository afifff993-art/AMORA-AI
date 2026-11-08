# Build guide (Phase 1)

Flutter's SDK does not run reliably inside Termux, so the simplest path from a
phone is: **Termux pushes the code to GitHub, GitHub Actions builds the APK.**

## Option A: GitHub Actions (phone friendly)

1. Create an empty repository on github.com (for example `amora`).
2. In Termux:
   ```
   pkg install git unzip
   unzip AMORA_AI_PROJECT.zip
   cd amora
   git init -b main
   git add .
   git commit -m "AMORA phase 1"
   git remote add origin https://github.com/YOUR_NAME/amora.git
   git push -u origin main
   ```
   (GitHub asks for a personal access token as the password.)
3. On GitHub open the **Actions** tab. The workflow "Android build (debug APK)"
   starts by itself. It takes about 5 to 10 minutes.
4. Open the finished run and download the artifact **amora-debug-apk**.
5. Unzip it, open `app-debug.apk` on the phone, allow "install unknown apps"
   for your browser or file manager, and install.

Later phases: after you add Kotlin code under `frontend/android/`, commit the
`android/` folder too (the script only generates it when it is missing).

## Option B: on a PC with Flutter 3.24.x

```
bash scripts/setup_android.sh
cd frontend
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter run            # phone connected with USB debugging
flutter build apk --debug
```

## Troubleshooting

- **Workflow fails at "Analyze"**: copy the red error text and send it with the
  command `FIX`.
- **`git push` asks for a password**: use a GitHub personal access token with
  `repo` scope, not your account password.
- **App installs but the name is lowercase**: run `bash scripts/setup_android.sh`
  once, then rebuild.
