let g:VMPoutputformat = 'html'
let g:VMPhtmlreader   = 'open'

function! PreviewMKD()

ruby << RUBY

  runtime  = VIM.evaluate('&runtimepath').split(',')
  css_base = runtime.detect { |path| File.exists? File.join(path, 'plugin', 'vmp.vim') }
  name     = VIM::Buffer.current.name.nil? ? 'Untitled' : File.basename(Vim::Buffer.current.name)
  runtime.each { |path| $LOAD_PATH.unshift(File.join(path, 'plugin', 'vim-markdown-preview')) }
  
  contents = Array.new(VIM::Buffer.current.count) { |i|VIM::Buffer.current[i + 1] }.join("\n")

  require('kramdown/kramdown')

  layout = <<-LAYOUT
   <!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

      <link rel="stylesheet"
            href="#{css_base}/plugin/vim-markdown-preview/stylesheets/safari-reader.css">
      </link>

      <title> #{name} </title>
      </head>
      <body>

        <div id="container">
          <div id="centered">
            <div id="article">
              <div class="page">
       
              #{Kramdown::Document.new(contents).to_html}
              </div>
            </div>
          </div>
        </div>

      </body>
    </html>
  LAYOUT

  case Vim.evaluate('g:VMPoutputformat')
    when 'html'
      reader = Vim.evaluate('g:VMPhtmlreader')
      file = File.join('/tmp', name + '.html')
      File.open(file, 'w') { |f| f.write(layout) }
      Vim.command("silent ! #{reader} '%s'" % [ file ])
    when 'pdf'
      Vim.message('output format not implemented yet.')
    else
      Vim.message('Unrecongized output format! Check g:VMPoutputformat.')
    end

RUBY
endfunction

:command! Mm :call PreviewMKD()
