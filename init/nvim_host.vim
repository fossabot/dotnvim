function! s:MergePath(cmd, path) abort
    return GetPath(systemlist(a:cmd)[0], a:path)
endfunction

function! s:GetPython(ver)
    return systemlist('command -v python'. a:ver)[0]
endfunction

if g:os ==# 'windows' && g:shell !=# 'cygwin'
    let s:prog_files = GetPath($PROGRAMFILES)
    let g:python_host_prog = s:prog_files
                \ .'/Python27/python.exe'
    let g:python3_host_prog = s:prog_files
                \ .'/Python36/python3.exe'
else
    let g:python_host_prog = s:GetPython(2)
    let g:python3_host_prog = s:GetPython(3)
endif

if exists('$NODE_GLOBAL_BIN')
    let g:node_host_prog = GetPath(
               \ $NODE_GLOBAL_BIN,
               \ 'neovim-node-host')
elseif get(g:, 'npm_cmd') ==# 'yarn'
    let g:node_host_prog = s:MergePath(
                \ 'yarn global bin',
                \ 'neovim-node-host')
elseif get(g:, 'npm_cmd') ==# 'npm i'
    let g:node_host_prog = s:MergePath(
                \ 'npm -g bin',
                \ 'neovim-node-host')
endif

if executable('gem')
    let g:ruby_host_prog = s:MergePath(
                \ 'gem environment gemdir',
                \ 'bin/neovim-ruby-host')
endif

