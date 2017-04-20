""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @msvalkon init.vim
" configuration mostly ripped off from:
"   https://github.com/spf13/spf13-vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {
    call plug#begin()
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'neomake/neomake'
    Plug 'townk/vim-autoclose'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'fatih/vim-go'
    Plug 'scrooloose/nerdtree'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'mhartington/deoplete-typescript',
    Plug 'leafgarland/typescript-vim',
    Plug 'lambdalisue/vim-gita', {'on': ['Gita']}
    Plug 'derekwyatt/vim-scala'
    Plug 'janko-m/vim-test'
    Plug 'ensime/ensime-vim'
    " colorschemes
    Plug 'chriskempson/base16-vim'
    Plug 'morhetz/gruvbox'
    Plug 'fatih/molokai'
    Plug 'junegunn/seoul256.vim'
    Plug '29decibel/codeschool-vim-theme'
    Plug 'joshdick/onedark.vim'
    call plug#end()
" }

" Set general stuff {
    let mapleader = ','
    set background=dark

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Always switch to the current file directory when a new buffer is
    " opened
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    function! ResCur()
    if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
    endif
    endfunction

    augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()

    set backup                      " Backups are nice ...
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif
" }
 
" neovim UI (colors ...) {
    if isdirectory(expand("~/.config/nvim/plugged/base16-vim"))
        ""let base16colorspace=256  " Access colors present in 256 colorspace
        ""colorscheme base16-eighties
        ""highlight LineNr ctermfg=yellow
    endif
  
    let g:airline_theme="onedark"
    colorscheme onedark

    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line
  
    highlight clear SignColumn      " SignColumn should match background
    ""highlight clear LineNr          " Current line number row will have same background color in relative mode
  
    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in  visual mode
    endif
  
    if has('statusline')
        set laststatus=2
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=longest,full
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set cmdheight=2                 " Height of the command bar
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set noswapfile
    set nobackup
    set termguicolors
" }

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,javascript,puppet,python,rust,twig,xml,rml,perl,sql,typescript,html,json autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml,typescript setlocal expandtab shiftwidth=2 softtabstop=2

    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
" }

" Key (re)Mappings {
    " Quickly open/reload vim
    nnoremap <leader>ev :split $MYVIMRC<CR>
    nnoremap <leader>sv :source $MYVIMRC<CR>

    " Easier moving in tabs and windows
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h

    " Easier split resizing
    map <A-S-J> <C-W>-
    map <A-S-K> <C-W>+
    map <A-S-H> <C-W><
    map <A-S-L> <C-W>>

    " Minimize and reset windows
    map <A-_> <C-W>_
    map <A-=> <C-W>=

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " Map <Space> to / (search)
    map <space> /

    " Disable highlight when <leader><cr> is pressed
    nmap <silent> <leader><cr> :set invhlsearch<CR>

    " jk is ESC
    inoremap jk <Esc>
    cnoremap jk <C-c>

    " Switch to the header file with cscope:
    " FIXME: should understand which file you are in..
    nnoremap <leader>h :cs find f %:t:r.h<cr>
    nnoremap <leader>vh :scs find f %:t:r.h<cr>

    " Map g* keys in Normal, Operator-pending, and Visual+select
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap $ :call WrapRelativeMotion("$")<CR>
    noremap <End> :call WrapRelativeMotion("$")<CR>
    noremap 0 :call WrapRelativeMotion("0")<CR>
    noremap <Home> :call WrapRelativeMotion("0")<CR>
    noremap ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap $ v:call WrapRelativeMotion("$")<CR>
    onoremap <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>

    " fast tab change
    map <S-H> gT
    map <S-L> gt

    " Stupid shift key fixes
    if has("user_commands")
        command! -bang -nargs=* -complete=file E e<bang> <args>
        command! -bang -nargs=* -complete=file W w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " Terminal mappings for neovim
    :tnoremap <Esc> <C-\><C-n>

    " This configuration allows using `Alt+{h,j,k,l}` to navigate between
    " windows no matter if they are displaying a normal buffer or a terminal
    " buffer in terminal mode.
    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l

    " open a terminal at the bottom (horizontal)
    nnoremap <leader>o :below 20sp term://$SHELL<CR>

    " open a bpython terminal below
    nnoremap <leader>bp :below 20sp term://bpython<CR>
    autocmd BufWinEnter,WinEnter term://* startinsert

    " open a vertical split terminal
    nnoremap <leader>vo :vsp term://$SHELL<CR>
" }

" Plugin configs {
    " vim-airline {
       let g:airline_symbols = {}
       let g:airline_powerline_symbols=1
       let g:airline_left_sep = ''
       let g:airline_left_alt_sep = ''
       let g:airline_right_sep = ''
       let g:airline_right_alt_sep = ''
       let g:airline_symbols.branch = ''
       let g:airline_symbols.readonly = ''
       let g:airline_symbols.linenr = ''
    " }

    " fzf.vim {
        nnoremap <silent> <leader>f :exe 'Files ' . <SID>fzf_root()<CR>
        nnoremap <silent> <leader>ag :Rag <CR>
        nnoremap <silent> <leader>b :Buffers <CR>

        " determine fzf root if .git exists..
        fun! s:fzf_root()
            let path = finddir(".git", expand("%:p:h").";")
            return fnamemodify(substitute(path, "\\.git", "", ""), ":p:h")
        endfun

        " Defines a new command 'Rag' which search from the git root "
        command! -nargs=* Rag
          \ call fzf#vim#ag(<q-args>, extend({'dir': s:fzf_root()}, g:fzf#vim#layout()))

        " Exit from fzf with esc
        au FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

        set rtp+=~/.fzf
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags
        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " Tabularize {
        if isdirectory(expand("~/.config/nvim/plugged/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }
    " indent_guides {
        if isdirectory(expand("~/.config/nvim/plugged/vim-indent-guides"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
            let g:indent_guides_auto_colors = 0
            hi IndentGuidesOdd  ctermbg=black
            hi IndentGuidesEven ctermbg=darkgrey
        endif
    " }

    " neomake {
        if isdirectory(expand("~/.config/nvim/plugged/neomake"))
            let g:neomake_python_enabled_makers = ['flake8']
            autocmd! BufWritePost * Neomake
        endif
    " }

    " vim-go {
        if isdirectory(expand("~/.config/nvim/plugged/vim-go"))
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_fields = 1
            let g:go_highlight_types = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_term_enabled = 1

            " Mappings
            " :GoDef
            au FileType go nmap <leader>ds <Plug>(go-def-split)
            au FileType go nmap <leader>dv <Plug>(go-def-vertical)
            au FileType go nmap <leader>dt <Plug>(go-def-tab)
            " :GoDoc
            au FileType go nmap <leader>gd <Plug>(go-doc)
            au FileType go nmap <leader>gv <Plug>(go-doc-vertical)
            au FileType go nmap <leader>gb <Plug>(go-doc-browser)
            " Show a list of interfaces implemented by the type under cursor 
            au FileType go nmap <Leader>s <Plug>(go-implements)
            au FileType go nmap <Leader>i <Plug>(go-info)
            au FileType go nmap <Leader>e <Plug>(go-rename)
            au FileType go nmap <leader>t  <Plug>(go-test)

        endif
    " }
    
    " NERDTree {
        if isdirectory(expand("~/.config/nvim/plugged/nerdtree"))
           map <C-e> :NERDTreeToggle<CR>
           let NERDTreeShowBookmarks=1
           let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
           let NERDTreeChDirMode=0
           let NERDTreeQuitOnOpen=1
           let NERDTreeMouseMode=2
           let NERDTreeShowHidden=1
           let NERDTreeKeepTreeInNewTab=1
           let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }
    
    " Deoplete.vim {
        if has("nvim")
            let g:deoplete#enable_at_startup = 1
            " deoplete tab-complete
            inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
        endif
    " }"

    " Deoplete-typescript {
        if isdirectory(expand("~/.config/nvim/plugged/deoplete-typescript"))
            let g:deoplete#enable_ignore_case = 1
            let g:deoplete#auto_complete_start_length = 0
            let g:auto_complete_start_length = 0
            let g:deoplete#enable_refresh_always = 1
            let g:deoplete#enable_debug = 1
            let g:deoplete#enable_profile = 1
            ""call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
        endif
    " }"
    " typescript-vim {
        if isdirectory(expand("~/.config/nvim/plugged/typescript-vim"))
            autocmd QuickFixCmdPost [^l]* nested cwindow
            autocmd QuickFixCmdPost    l* nested lwindow
        endif
    " }
    "
    " test-vim {
        if isdirectory(expand("~/.config/nvim/plugged/vim-test"))
            let test#strategy = "neovim"
            let test#python#runner = 'pytest'
            nmap <silent> <leader>t :TestNearest<CR>
            nmap <silent> <leader>T :TestFile<CR>
        endif
    " }
    "
    " ensime-vim {
        if isdirectory(expand("~/.config/nvim/plugged/ensime-vim"))
            let ensime_server_v2=1
            autocmd BufWritePost *.scala silent :EnTypeCheck
            au FileType scala nnoremap <localleader>df :EnDeclarationSplit v<CR>
        endif
    " }

" Functions {
    function! LoadCscope()
        let db = findfile("cscope.out", ".;")
        if (!empty(db))
            let path = strpart(db, 0, match(db, "/cscope.out$"))
            set nocscopeverbose " suppress 'duplicate connection' error
            exe "cs add " . db . " " . path
            set cscopeverbose
        endif
    endfunction

    au BufEnter /* call LoadCscope()

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction

   " }
" }
