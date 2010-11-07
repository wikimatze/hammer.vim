set runtimepath+=~/.vim/plugin/vim-markdown-preview

function! PreviewMKD()
  ruby << RUBY


    VIM.evaluate('&runtimepath').split(',').each do |path|
      $LOAD_PATH.unshift(File.join(path, 'plugin', 'vim-markdown-preview'))
    end

    require('kramdown/kramdown')

    text = Array.new(VIM::Buffer.current.count) do |i|
      VIM::Buffer.current[i + 1]
    end.join("\n")

    VIM::Buffer.current.name.nil? ? (name = 'No Name.md') : (name = Vim::Buffer.current.name)

    preview_path = VIM.evaluate('&runtimepath').split(',').select{|path| path =~ /vim-markdown-preview/}.first
    "cssfile = File.open("#{preview_path}/plugin/markdown-preview.css")
    cssfile = File.open("#{preview_path}/stylesheets/safari-reader.css")
    style = cssfile.read

    layout = <<-LAYOUT
  <!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <style type="text/css">
        #{style}
      </style>

      <title> #{File.basename(name)} </title>
      </head>
      <body>

        <div id="container">
        <div id="centered">
        <div id="article">
        <div class="page">
          #{Kramdown::Document.new(text).to_html}
        </div>
        </div>
        </div>
        </div>
      </body>
    </html>
    LAYOUT


    unless File.extname(name) =~ /\.(md|mkd|markdown)/
      VIM.message('This file extension is not supported for Markdown previews')
    else
      file = File.join('/tmp', File.basename(name) + '.html')
      File.open('%s' % [ file ], 'w') { |f| f.write(layout) }
      # Open the html file
      # Vim.command("silent !open '%s'" % [ file ])

      # Create and open a PDF file
      pdffile = File.join('/tmp', File.basename(name) + '.pdf')
      system("wkpdf --source #{file} --output #{pdffile}")
      Vim.command("silent !open '%s'" % [ pdffile ])
    end
RUBY
endfunction

:command! Mm :call PreviewMKD()
