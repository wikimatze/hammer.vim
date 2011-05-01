ruby $LOAD_PATH.unshift Vim.evaluate('fnamemodify(expand("<sfile>"), ":p:h")')

ruby require 'rubygems'
ruby require 'github/markup'
ruby require 'hammer.rb'
ruby require 'hammer/env.rb'
ruby require 'vim/improvedbuffer'
ruby require 'erb'

function! Hammer()

ruby << RUBY
  buffer = Vim::Buffer.current.extend Vim::ImprovedBuffer

  if GitHub::Markup.can_render? buffer.basename
    File.open "/tmp/#{buffer.basename}.html", 'w' do |f|
      f.write Hammer.render('default') { GitHub::Markup.render(buffer.name, buffer[1..-1]) }
    end

    Vim.command "silent ! open /tmp/#{buffer.basename}.html"
    Vim.command "redraw !"
  else
    Vim.message "It is not possible to render #{buffer.extname} files." 
  end

RUBY

endfunction

:command! Hammer :call Hammer()
