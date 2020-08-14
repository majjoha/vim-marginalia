" Maintainer: Mathias Jean Johansen <mathias@mjj.io>
" License: ISC

" Convert string to a function reference
function! marginalia#utils#function(name)
  return function(a:name)
endfunction

" Escape the filename and edit it
function! marginalia#utils#edit_file(file) abort
  execute 'edit ' . fnameescape(a:file)
endfunction

" Return a list of filenames without the file extension
function! marginalia#utils#files(directory)
  return map(
  \   split(globpath(a:directory, '*'), '\n'),
  \   { _, file -> fnamemodify(file, ':t:r') }
  \ )
endfunction
