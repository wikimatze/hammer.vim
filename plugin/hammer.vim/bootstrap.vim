if !exists('g:HAMMER_INSTALL_PATH') 
  let g:HAMMER_INSTALL_PATH = fnamemodify(expand("<sfile>"), ":p:h")
end

if !exists('g:HAMMER_SILENCE_WARNINGS')
  let g:HAMMER_SILENCE_WARNINGS = 0
endif 

if !exists('g:HAMMER_DIRECTORY')
  if has('win32') || has('win64')
    let g:HAMMER_DIRECTORY = $TEMP
  else
    let g:HAMMER_DIRECTORY = '/tmp'
  end
endif

if !exists('g:HAMMER_BROWSER')
  if has('mac')
    let g:HAMMER_BROWSER = 'open'
  elseif has('win32') || has('win64')
    ruby require 'hammer/vim-windows/rubygems'
    let g:HAMMER_BROWSER = 'start'
  elseif has('unix') && executable('xdg-open')
    let g:HAMMER_BROWSER = 'xdg-open'
  else
    let g:HAMMER_BROWSER = ''
  end
endif

if !exists('g:HAMMER_BROWSER_ARGS')
  let g:HAMMER_BROWSER_ARGS = ''
endif

if !exists('g:HAMMER_TEMPLATE')
  let g:HAMMER_TEMPLATE = 'default'
endif

:command! Hammer :call hammer#Hammer()
