require 'open3'

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
        text = $2

        Open3.popen3 "pygmentize #{language} -f html" do |stdin, stdout|
          stdin.write text
          stdin.close
          text = stdout.read
        end

        text
      end

      @text
    end

  end
end
