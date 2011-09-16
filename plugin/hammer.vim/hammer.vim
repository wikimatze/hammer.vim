if has('ruby')
  source fnamemodify(expand("<sfile>"), ":p:h") . "bootstrap"
  
  function! Hammer()
  ruby << RUBY
    buffer = Vim::Buffer.current.extend Vim::ImprovedBuffer

    if GitHub::Markup.can_render? buffer.basename
      path = File.join Hammer::ENV.directory, "#{buffer.basename}.html"

      File.open path, 'w' do |f|
        f.write Hammer.render { GitHub::Markup.render(buffer.basename, buffer[0..-1]) }
      end

      Hammer.open_browser path
    elsif buffer.extname =~ /^\.(xhtml|html)$/
      Hammer.open_browser buffer.name
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
