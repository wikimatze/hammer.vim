if has('ruby')
  ruby $: << File.join(Vim.evaluate('g:HAMMER_INSTALL_PATH'), 'lib') 
  ruby require 'hammer'
  ruby Hammer.load_dependencies! 
  ruby Hammer.load_renderers!

  function! hammer#Hammer()
    ruby <<RENDER!
      buffer = Vim::Buffer.current.extend Vim::ImprovedBuffer
      Hammer.render!(buffer)
RENDER!
  endfunction
else
  function! hammer#Hammer()
    echo "Sorry, hammer.vim requires vim to be built with Ruby support."
  endfunction
end
