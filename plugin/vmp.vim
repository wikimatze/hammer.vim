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
    cssfile = File.open("#{preview_path}/plugin/markdown-preview.css")
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

        <h4 id="title">
          #{File.basename(name)}
        </h4>

        <div id="content">
          #{Kramdown::Document.new(text).to_html}
        </div>
      </body>
    </html>
    LAYOUT


    unless File.extname(name) =~ /\.(md|mkd|markdown)/
      VIM.message('This file extension is not supported for Markdown previews')
    else
      file = File.join('/tmp', File.basename(name) + '.html')
      File.open('%s' % [ file ], 'w') { |f| f.write(layout) }
      Vim.command("silent !open '%s'" % [ file ])
    end
RUBY
endfunction

:command! Mm :call PreviewMKD()
