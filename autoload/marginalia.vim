" Maintainer: Mathias Jean Johansen <mathias@mjj.io>
" License: ISC

" Return a timestamp that will be the prefix of the filename of new notes
function! marginalia#default_file_prefix_function() abort
  return strftime('%Y%m%d%H%M-')
endfunction

" Call the file prefix function and return the result
function! marginalia#file_prefix() abort
  let l:function_ref = get(g:, 'marginalia_file_prefix_function')
  let l:result = marginalia#utils#function(function_ref)()
  return l:result
endfunction

" Create a new note
function! marginalia#new(title) abort
  let l:file_prefix = marginalia#file_prefix()
  let l:filename = join(
  \ [
  \   l:file_prefix,
  \   a:title,
  \   g:marginalia_file_extension
  \ ],'')
  call marginalia#utils#edit_file(g:marginalia_notes_path . '/' . l:filename)
  call setline('.', g:marginalia_header_format)
  startinsert!
endfunction

" Edit note
function! marginalia#edit(title) abort
  let l:filename =
  \  g:marginalia_notes_path . '/' . a:title . g:marginalia_file_extension

  if !filereadable(l:filename)
    call marginalia#new(a:title)
    return
  endif

  call marginalia#utils#edit_file(l:filename)
endfunction

" Tab completion for the `MarginaliaEdit` command
function! marginalia#complete(arg_lead, ...) abort
  let l:files = marginalia#utils#files(g:marginalia_notes_path)
  return filter(l:files, 'v:val =~ a:arg_lead')
endfunction

" Find backlinks to the current file
function! marginalia#find_backlinks() abort
  execute 'grep ' . expand('%:t') . ' ' . g:marginalia_notes_path
  execute 'cw'
endfunction

" Find tag references
function! marginalia#find_tag_references(...) abort
  " If a tag is provided, then search for it, otherwise search for the word
  " under the cursor
  if a:0 == 1
    let l:tag = a:1
  else
    let l:tag = expand('<cword>')
  endif

  let l:query =  '"\' . join([g:marginalia_tag_identifier, l:tag], '') . '\b"'
  let l:path = l:query . ' ' . g:marginalia_notes_path
  execute 'grep ' . l:path
  execute 'cw'
endfunction

" Convert the word under the cursor to a tag
function! marginalia#convert_word_to_tag() abort
  let l:word = expand('<cword>')
  execute 'normal! ciw' . g:marginalia_tag_identifier . l:word
endfunction

" Build pairs of filenames and titles for the quickfix list 
function! marginalia#qf_items() abort
  return map(
  \  split(
  \    globpath(
  \      g:marginalia_notes_path, '*' . g:marginalia_file_extension
  \    ), '\n'
  \  ),
  \  { index, file ->
  \    [file, substitute(readfile(file)[0], g:marginalia_header_format, '', '')] 
  \  }
  \ )
endfunction

" List all notes in the quickfix list
function! marginalia#list() abort
  let l:notes = []
  for [file, title] in marginalia#qf_items()
    call add(l:notes, {
    \  'filename': file,
    \  'lnum': 1,
    \  'col': 1,
    \  'text': title
    \ })
  endfor
  call setqflist(l:notes, 'r')
  call setqflist([], 'a', {'title': 'Notes'})
  execute 'cw'
endfunction
