function! PreviewMKD()
  ruby << RUBY
   
    VIM.evaluate('&runtimepath').split(',').each do |path|
      $LOAD_PATH.unshift(File.join(path, 'plugin', 'vim-markdown-preview'))
    end
  
    require('kramdown/kramdown')

    text = Array.new(VIM::Buffer.current.count) do |i| 
      VIM::Buffer.current[i + 1]
    end.join("\n")

    style = <<-STYLE
    <style type="text/css">
    body div#content { 
      margin            : 0 auto;
      width             : 920px;
      background-color  : #f8f8f8;
      padding           : .7em;
      font-size         : 13.34px;
      font-family       : verdana, sans-serif;
      border            : 1px #E0E0E0 solid; 
    }

    body div#content h1, body div#content h2 {
     padding-top  : 10px;
     border-top   : 4px solid #E0E0E0;
    }

    body div#content pre {
      padding          : 5px;
      border-style     : solid;
      border-width     : 1px;
      border-color     : #E0E0E0;
      background-color : #F8F8FF;
    }

    body div#content pre code {
      padding          : 5px;
      background-color : #F8F8FF;
      border           : none;
    }

    body div#content code {
      font-family      : courier, fixed;
      display          : inline-block;
      padding          : 0px 2px 0px 2px;
      background-color : #F8F8FF;
      border           : 1px #E0E0E0 solid;
    }

    body h4#title {
      font-family : verdana, sans-serif;
      display     : block;
      margin      : 0 auto;
      width       : 920px;
    }
    </style> 
    STYLE

    layout = <<-LAYOUT
  <!DOCTYPE html 
    PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      #{style}

      <title> #{File.basename(VIM::Buffer.current.name)} </title>
      </head>
      <body>
        
        <h4 id="title">
          #{File.basename(VIM::Buffer.current.name)}
        </h4>

        <div id="content">
          #{Kramdown::Document.new(text).to_html}
        </div>
      </body>
    </html>
    LAYOUT


    unless File.extname(VIM::Buffer.current.name) =~ /.(md|mkd|markdown)/ 
      VIM.message('This file extension is not supported for Markdown previews')
    else
      file = File.join('/tmp', File.basename(VIM::Buffer.current.name) + '.html')
      File.open('%s' % [ file ], 'w') { |f| f.write(layout) }
      VIM.command(":! open %s" % [ file ])
    end 
RUBY
endfunction

:command! Mm :call PreviewMKD()<CR>
