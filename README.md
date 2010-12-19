## vim-markdown-preview
  vim-markdown-preview is a (customizable) plugin for the vim editor to preview markdown documents.

## Documentation

  See [doc/vmp.txt](http://github.com/robgleeson/vim-markdown-preview/blob/master/doc/vmp.txt)  
  If you install vim-markdown-preview, please run `:helptags $HOME/.vim/doc` to be able to view
  the documentation from within vim.

## Install
**Download**  

* Option 1  
  Clone the repository! The master branch is where stable, or soon-to-be-released code lives.
   
* Option 2  
  You can download versioned releases from the 
  [downloads](http://github.com/robgleeson/vim-markdown-preview/downloads) page.

**Automatic installation**  
  vim-markdown-preview is bundled with an installer script which will install to `$HOME/.vim/plugin/`

    sh install.sh

## Usage
  Send vim the command `:Mm` for a preview of your markdown document.  
  Alternatively, bind `:Mm` to a key binding: 
  `map <leader>p :Mm<CR>` 


## Dependencies
  * vim
  * Ruby support for vim.
  * kramdown (bundled with this package)

## Notes
  If you're previewing documents in the links browser, remember to use ctrl+r after previewing a document
  for the 2nd, 3rd, ..., etc time or you'll be left with the cached version.

## Screenshots
  [links browser](http://ompldr.org/vNm1vYg)  
  .. more to come!

## Bugs
  Bugs are tracked through 
  [The GitHub Issue Tracker](http://github.com/robgleeson/vim-markdown-preview/issues).


