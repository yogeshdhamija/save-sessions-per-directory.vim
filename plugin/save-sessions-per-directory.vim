" save-sessions-per-directory.vim - session management plugin
" Maintainer: Yogesh Dhamija <yogeshdhamija.github.io>
" Version: 0.1

if exists("g:loaded_save_sessions_per_directory")
    finish
endif
let g:loaded_save_sessions_per_directory = 1

command StartKeepingSession call s:start_keeping_session()
command STARTKEEPINGSESSION call s:start_keeping_session()

command StopKeepingSession call s:stop_keeping_session()
command STOPKEEPINGSESSION call s:stop_keeping_session()

augroup save_sessions_per_directory_vim_launch_augroup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * nested call s:load_session_if_vim_not_launched_with_args() 
augroup END

function! s:start_keeping_session() abort
    augroup save_sessions_per_directory_auto_saving_sessions_augroup
        autocmd!
        autocmd FileWritePost,VimLeavePre * call s:save_session()
    augroup END
    let s:vim_session_folder = getcwd()
    redraw!
    echomsg "Added autocmd to execute 'mksession! ".s:vim_session_folder."/.vim/session.vim'."
endfunction

function! s:stop_keeping_session() abort
    if(exists("s:vim_session_folder"))
        call delete(s:vim_session_folder."/.vim/session.vim")
        augroup save_sessions_per_directory_auto_saving_sessions_augroup
            autocmd!
        augroup END
        redraw!
        echomsg "Executed '!rm ".s:vim_session_folder."/.vim/session.vim' and removed autocmd which executed mksession"
    endif
endfunction

function! s:load_session_if_vim_not_launched_with_args() abort
    if argc() == 0 && !exists("s:std_in")
        if filereadable(expand('.vim/session.vim'))
            silent call s:start_keeping_session()
            execute 'silent source .vim/session.vim'
            redraw!
            echomsg "Executed ':source ".s:vim_session_folder."/.vim/session.vim'"
        endif
    endif
endfunction

function! s:save_session() abort
    let l:sessionoptions = &sessionoptions
    try
        set sessionoptions&
        set sessionoptions-=options
        call mkdir(s:vim_session_folder."/.vim", "p", "0700")
        execute 'mksession! '.s:vim_session_folder.'/.vim/session.vim'
    finally
        let &sessionoptions = l:sessionoptions
    endtry
endfunction

