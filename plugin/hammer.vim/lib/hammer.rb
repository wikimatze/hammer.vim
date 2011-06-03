module Hammer

  class << self

    def open_browser path
      Vim.command "silent ! #{Shellwords.escape Hammer::ENV.browser} #{Shellwords.escape path}"
      Vim.command "redraw!"
    end

    def render
      template = ERB.new File.read(Hammer::ENV.template) 
      template.result binding 
    end

  end
 
end
