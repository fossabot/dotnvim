if exists('b:current_syntax')
    let s:current_syntax = b:current_syntax
    unlet b:current_syntax
endif

syn include @issPascal syntax/pascal.vim

if exists('s:current_syntax')
    let b:current_syntax = s:current_syntax
else
    unlet! b:current_syntax
endif

syntax region issPascal matchgroup=issDirective
            \ start=/\[Code\]/ end=/^\[\w\+\]$/
            \ keepend containedin=ALL contains=@issPascal

