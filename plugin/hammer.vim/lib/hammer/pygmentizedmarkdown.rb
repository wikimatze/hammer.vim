require 'digest/md5'

module Hammer
  class PygmentizedMarkdown 

    def initialize text
      @text = text  
    end
  
    def to_html
      @text = Redcarpet.new(@text, :gh_blockcode, :fenced_code).to_html

      # Regexp taken from YARD.
      @text.gsub!(/<pre\s*(?:lang="(.+?)")?>(?:\s*<code>)?(.+?)(?:<\/code>\s*)?<\/pre>/m) do
        language = $1.nil? ? "-g" : "-l #{$1}"
        text     = $2

        file = File.join(Hammer::ENV.directory, Digest::MD5.hexdigest(text))
        File.open(file, 'w') { |f| f.write(text) }
        
        Vim.command("silent ! pygmentize #{language} -f html #{file} &")
        Vim.command("redraw!")

        text = File.read(file)
      end

      @text
    end

  end
end
