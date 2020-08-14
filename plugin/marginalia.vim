" Maintainer: Mathias Jean Johansen <mathias@mjj.io>
" License: ISC

if exists('g:loaded_marginalia') || &cp
  finish
endif
let g:loaded_marginalia = 1

" Configure the path to the notes folder (Default: '~/notes')
let g:marginalia_notes_path = get(g:, 'marginalia_notes_path', '~/notes')

" Configure the default file extension for new notes (Default: '.md')
let g:marginalia_file_extension = get(g:, 'marginalia_file_extension', '.md')

" Configure the default header format for new notes (Default: '# ')
let g:marginalia_header_format = get(g:, 'marginalia_header_format', "# ")

" Configure the tag identifier for searching notes (Default: '#')
let g:marginalia_tag_identifier = get(g:, 'marginalia_tag_identifier', '#')

" Configure the default function for prefixing filenames (Default:
" 'marginalia#file_prefix_function')
let g:marginalia_file_prefix_function =
  \ get(
  \   g:,
  \   'marginalia_file_prefix_function',
  \   'marginalia#default_file_prefix_function'
  \ )

command! -nargs=1 MarginaliaNew call marginalia#new(<f-args>)
command! -nargs=? -complete=customlist,marginalia#complete
  \ MarginaliaEdit call marginalia#edit(<f-args>)
command! -nargs=0 MarginaliaList call marginalia#list()
command! -nargs=0 MarginaliaFindBacklinks call marginalia#find_backlinks()
command! -nargs=? MarginaliaFindTagReferences
  \ call marginalia#find_tag_references(<f-args>)
command! -nargs=0 MarginaliaConvertWordToTag 
  \ call marginalia#convert_word_to_tag()
