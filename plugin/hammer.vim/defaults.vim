if !exists('g:HammerDirectory')
  if has('win32') || has('win64')
    let g:HammerDirectory = $TEMP
  else
    let g:HammerDirectory = '/tmp'
  end
endif

if !exists('g:HammerBrowser')
  if has('mac')
    let g:HammerBrowser = 'open'
  elseif has('win32') || has('win64')
    let g:HammerBrowser = 'start'
  elseif has('unix') && executable('xdg-open')
    let g:HammerBrowser = 'xdg-open'
  else
    let g:HammerBrowser = ''
  end
endif

if !exists('g:HammerTemplate')
  let g:HammerTemplate = 'default'
endif

