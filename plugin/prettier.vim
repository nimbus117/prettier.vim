let s:parsers = [ "babel","babel-flow","babel-ts","css","flow",
      \ "graphql","html","json","json-stringify","json5","less",
      \ "lwc","markdown","mdx","scss","typescript","yaml" ]

function! s:Prettier(...) abort
  if executable('npx')
    if (a:0 > 2)
      let l:parser = a:3
    elseif (index(s:parsers, &filetype) >= 0)
      let l:parser = &filetype
    elseif (&filetype == "javascript" || &filetype == "javascriptreact")
      let l:parser = 'babel'
    elseif (&filetype == "typescriptreact")
      let l:parser = "typescript"
    else
      echo "Unknown filtype, specify parser to use"
      return
    endif
    execute a:1 . "," . a:2 . "!npx --quiet prettier --parser " . l:parser
  else
    echo "npx command not found"
  endif
endfunction

function! s:PrettierComplete(ArgLead,CmdLine,CursorPos) abort
  let l:argCount = len(split(a:CmdLine, " "))
  let l:matchingParsers = filter(copy(s:parsers), 'v:val =~ "^'. a:ArgLead .'"')
  if (l:argCount == 1 || (l:argCount == 2 && a:CmdLine =~ '\S$'))
    return l:matchingParsers
  endif
endfunction

command!
      \ -complete=customlist,s:PrettierComplete
      \ -nargs=?
      \ -range=%
      \ Prettier
      \ call s:Prettier(<line1>, <line2>, <f-args>)
