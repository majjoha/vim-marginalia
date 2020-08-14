# 📖 Marginalia
Marginalia is a lightweight plugin for writing and managing notes. It aims to be
a good, unobtrusive Vim citizen, and it relies on built-in functionality, e.g.,
`:grep` and `gf`, does not introduce changes to the `filetype` of your notes, or
shadow your existing key bindings.

The plugin supports creating and editing notes, listing all your notes, finding
backlinks, and searching your notes by tags.

## Installation
```sh
git clone https://github.com/majjoha/vim-marginalia.git ~/.vim/pack/packages/start/vim-marginalia
```

## Commands
| Command                              | Description                           |
|--------------------------------------|---------------------------------------|
| `:MarginaliaNew {title}`             | Create a new note.                    |
| `:MarginaliaEdit {title}`            | Edit a note.                          |
| `:MarginaliaList`                    | List all notes.                       |
| `:MarginaliaFindBacklinks`           | Find references to the current note.  |
| `:MarginaliaFindTagReferences {tag}` | Find references to a provided tag or the word under the cursor. |
| `:MarginaliaConvertWordToTag`  | Convert the word under the cursor to a tag. |

## Options
#### `g:marginalia_notes_path`
By default, notes are stored in `~/notes`. If you want to store them elsewhere,
you need to set this variable. For instance,

```vim
let g:marginalia_notes_path = "~/Dropbox/notes"
```

Default is `~/notes`.

#### `g:marginalia_file_extension`
Marginalia is configured to work with Markdown documents by default. If you want
to use a different format, configure it like so:

```vim
let g:marginalia_file_extension = ".adoc"
```

Default is `.md`.

#### `g:marginalia_header_format`
Since Marginalia uses Markdown by default, the header format is set to `# `.
This can be changed by setting the `g:marginalia_header_format` variable:

```vim
let g:marginalia_file_extension = "= "
```

Default is `# `.

#### `g:marginalia_tag_identifier`
Marginalia uses the Twitter-style tag identifier `#` by default. If you want a
different format, this variable needs to be changed. For instance,

```vim
let g:marginalia_tag_identifier = "@"
```

Default is `#`.

#### `g:marginalia_file_prefix_function`
If the global options are left untouched, new notes are created using the
filename format: `%Y%m%d%H%M-your-note-name.md`. If you want to change the file
prefix, i.e., `%Y%m%d%H%M-`, you need to define a custom function that returns a
string. For instance, a date prefix would be set as such:

```vim
function! DatePrefix() abort
  return strftime('%Y%m%d-')
endfunction

let g:marginalia_file_prefix_function = 'DatePrefix'
```

Default is `marginalia#default_file_prefix_function`.

## Suggested key mappings
```vim
nnoremap <Leader>mnn :MarginaliaNew<Space>
nnoremap <Leader>men :MarginaliaEdit<Space>
nnoremap <silent><Leader>mln :MarginaliaList<CR>
nnoremap <silent><Leader>mfb :MarginaliaFindBacklinks<CR>
nnoremap <Leader>mft :MarginaliaFindTagReferences<Space>
nnoremap <silent><Leader>mcw :MarginaliaConvertWordToTag<CR>
```

## FAQ
### How can I use folders for storing my notes?
Simply define a prefix function that returns an empty string:

```vim
function! EmptyPrefix() abort
  return ''
endfunction

let g:marginalia_file_prefix_function = 'EmptyPrefix'
```

Now when you run `:MarginaliaNewNote technology/vim`, a new note with the name
`vim` is stored in your `technology` folder.

### Can I use wiki-style links?
Yes. In fact, this behavior can be enabled anywhere in Vim. Simply add `set
suffixesadd=.md` (for notes in Markdown format) to your `.vimrc`, and you can
now visit links, e.g., `[[today-i-learned-vim]]`, using `gf`.

## Related projects
- [vim-notes](https://github.com/xolox/vim-notes)
- [vim-pad](https://github.com/fmoralesc/vim-pad)
- [VimWiki](https://github.com/vimwiki/vimwiki)
- [Waikiki](https://github.com/fcpg/vim-waikiki)
- [wiki.vim](https://github.com/lervag/wiki.vim)

## License
See [LICENSE](./LICENSE).
