" uss-sessions.vim - session management plugin
" Maintainer: Yogesh Dhamija <ydhamija96.github.io>
" Version: 0.1

if exists("g:loaded_uss_sessions")
    finish
endif
let g:loaded_uss_sessions = 1

if !exists(":StartKeepingSession")
    command! StartKeepingSession call s:start_keeping_session()
endif
if !exists(":StopKeepingSession")
    command! StopKeepingSession call s:stop_keeping_session()
endif

augroup uss_sessions_vim_launch_augroup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * nested call s:load_session_if_vim_not_launched_with_args() 
augroup END

function! s:start_keeping_session() abort
    augroup uss_sessions_auto_saving_sessions_augroup
        autocmd!
        autocmd FileWritePost,VimLeavePre * call s:save_session()
    augroup END
    let s:vim_session_folder = getcwd()
    redraw!
    echomsg "USS-Sessions: Added autocmd to execute 'mksession! ".s:vim_session_folder."/.vim/session.vim'."
endfunction

function! s:stop_keeping_session() abort
    if(exists("s:vim_session_folder"))
        call delete(s:vim_session_folder."/.vim/session.vim")
        augroup uss_sessions_auto_saving_sessions_augroup
            autocmd!
        augroup END
        redraw!
        echomsg "USS-Sessions: Executed '!rm ".s:vim_session_folder."/.vim/session.vim' and removed autocmd which executed mksession"
    endif
endfunction

function! s:load_session_if_vim_not_launched_with_args() abort
    if argc() == 0 && !exists("s:std_in")
        if filereadable(expand('.vim/session.vim'))
            silent call s:start_keeping_session()
            execute 'silent source .vim/session.vim'
            redraw!
            echomsg "USS-Sessions: Executed ':source ".s:vim_session_folder."/.vim/session.vim'"
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

