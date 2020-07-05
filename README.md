# uss-sessions.vim

Simple session management for vim. See `:help uss-sessions.txt`.

Features:
- Echoes what's happening under the hood, so you're aware.
- Per directory. `:StartKeepingSession` from `~/foo`. Now, whenever you open vim from `~/foo` (without args), it will pick up from where you left off.
