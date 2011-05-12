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
    
    " Crazy hack to be able to load Gems on Vim/Windows.
    " No idea _why_ rubygems can't be loaded from inside vim ...
    ruby << GEM_HACK
      require 'rubygems'
      Gem.source_index.find_name(//).each do |spec|
        spec.require_paths.each do |require_path|
       	  $LOAD_PATH.push File.join(spec.full_gem_path, require_path)
 	      end
      end	
GEM_HACK

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

