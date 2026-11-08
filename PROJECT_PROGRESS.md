# PROJECT_PROGRESS

| Phase | Status |
|---|---|
| 1 Foundation + UI | Code written. **Not yet compiled or tested** (see below) |
| 2 to 10 | Not started |

## Phase 1 contents
Theme (dark/light), home screen, animated AI core with 5 states
(idle/listening/thinking/speaking/error), settings (theme mode, animation
intensity, saved on device), unit and widget tests, build script, GitHub
Actions workflow.

Not in Phase 1 (still to come): chat, backend, voice, memory, commands.
The state chips on the home screen only preview animations.

## Phase 1 test checklist
1. Push to GitHub; the Actions run finishes green (analyze + test + build).
2. Install the APK; the home screen shows the glowing core.
3. Tap Idle, Listening, Thinking, Speaking, Error: the animation changes each time.
4. Settings: switch Dark / Light / System; the app theme changes.
5. Settings: set animation to Off; the core stops moving. Restart the app; both settings are remembered.
6. Card says "Backend: not connected" (correct for Phase 1).

## Known gaps
- The code was written without a Flutter SDK available, so it has not been
  compiled. If the workflow fails, send the error with `FIX`.
