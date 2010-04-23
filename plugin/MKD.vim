function! PreviewMKD()

ruby << EOF
  require 'rubygems'
  require 'bluecloth'

  t = ""
  VIM::Buffer.current.count.times {|i| t += "#{VIM::Buffer.current[i + 1]}\n"}
  html_file = VIM::Buffer.current.name.gsub(/.(md|mkd)$/, '.html')


  style = <<-STYLE
  <style>
  body div#content { 
    margin            : 0 auto;
    width             : 800px;
    background-color  : #f8f8f8;
    padding           : .7em;
    font-size         : 13.34px;
    font-family       : verdana, sans-serif; 
  }

  body div#content code {
    font-family      : courier, fixed;
    display          : inline;
    background-color : #F8F8FF;
  }

  body div#content pre {
    padding          : 5px;
    border-style     : solid;
    border-width     : 1px;
    border-color     : #000;
    background-color : #F8F8FF;
  }

  body h4#title {
    font-family : verdana, sans-serif;
    display     : block;
    margin      : 0 auto;
    width       : 800px;
  }
  </style> 
  STYLE

  layout = <<-LAYOUT
  <html>
    <head>
    #{style}
    </head>
    <body>
      
      <h4 id="title">
        #{File.basename(VIM::Buffer.current.name)}
      </h4>

      <div id="content">
        #{BlueCloth.new(t).to_html}
      </div>
    </body>
  </html>
  LAYOUT


  if html_file == VIM::Buffer.current.name
    print "Error! - This file extension is not supported for Markdown previews"
  else
    File.open(html_file, 'w') do |f|
      f.write(layout)
    end
    system("open #{html_file}; sleep 2; rm #{html_file}")
  end
  
  
EOF
endfunction

:command! Mm :call PreviewMKD()<CR>

