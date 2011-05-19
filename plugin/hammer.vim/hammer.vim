if has('ruby')
  let g:HammerLocation = fnamemodify(expand("<sfile>"), ":p:h")

  ruby $LOAD_PATH.unshift Vim.evaluate('g:HammerLocation')
  ruby require 'rubygems'
  ruby require 'lib/hammer'
  ruby require 'lib/hammer/env'
  ruby require 'lib/vim/improvedbuffer'
  ruby require 'erb'
  ruby << REQUIRE_GHMARKUP
  begin
    require 'github/markup'
  rescue LoadError => e
    unless Vim.evaluate('g:HammerQuiet') == 1
      Vim.message "github-markup is missing. Please run `gem install github-markup`"
      Vim.message "Set g:HammerQuiet to 1 to silence this message"
    end
  end
REQUIRE_GHMARKUP


  function! Hammer()
  ruby << RUBY
    buffer = Vim::Buffer.current.extend Vim::ImprovedBuffer

    if GitHub::Markup.can_render? buffer.basename
      File.open File.join(Hammer::ENV.directory, "#{buffer.basename}.html"), 'w' do |f|
        f.write Hammer.render { GitHub::Markup.render(buffer.basename, buffer[1..-1]) }
      end

      Vim.command "silent ! #{Hammer::ENV.browser} #{File.join Hammer::ENV.directory, buffer.basename}.html"
      Vim.command "redraw!"
    elsif buffer.extname =~ /^\.(xhtml|html)$/
      Vim.command "silent ! #{Hammer::ENV.browser} #{buffer.name}"
      Vim.command "redraw!"
    else
      Vim.message "It is not possible to render #{buffer.extname} files. Missing dependency?" 
    end
RUBY
  endfunction

else
  function! Hammer()
    echo "Sorry, hammer.vim requires vim to be built with Ruby support"
  endfunction
end

:command! Hammer :call Hammer()
