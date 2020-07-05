# uss-sessions.vim

Simple session management for vim. See `:help uss-sessions.txt` once installed, or see the `doc/` directory.

Features:
- Echoes what's happening under the hood, so you're aware.
- Per directory. `:StartKeepingSession` from `~/foo`. Now, whenever you open vim from `~/foo` (without args), it will pick up from where you left off.

To install: 
- Using [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'ydhamija96/uss-sessions.vim'`
