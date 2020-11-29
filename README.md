# save-sessions-per-directory.vim

Simple session management for vim. See `:help save-sessions-per-directory.txt` once installed, or see the `doc/` directory.

Features:
- Echoes what's happening under the hood, so you're aware.
- Per directory. `:StartKeepingSession` from `~/foo`. Now, whenever you open vim from `~/foo` (without args), it will pick up from where you left off.

To install: 
- Using [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'yogeshdhamija/save-sessions-per-directory.vim'`
