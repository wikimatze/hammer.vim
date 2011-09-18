require 'cgi'

class Hammer::Pygment 
  
  def initialize buffer
    @text = Redcarpet.new(buffer.to_s, :gh_blockcode, :fenced_code).to_html
    @out  = File.join Hammer::ENV.directory, buffer.basename + ".pygments_out"
    @in   = File.join Hammer::ENV.directory, buffer.basename + ".pygments_in" 
  end

  def to_html
    # Regexp taken from YARD.
    @text.gsub!(/<pre\s*(?:lang="(.+?)")?>(?:\s*<code>)?(.+?)(?:<\/code>\s*)?<\/pre>/m) do
      language = $1.nil? ? "-g" : "-l #{$1}"
      text     = CGI.unescapeHTML($2)

      File.open(@in, 'w') { |f| f.write(text) }      
      Vim.command("silent ! pygmentize #{language} -f html -o #{@out} #{@in}")
      Vim.command("redraw!")

      File.read(@out)
    end
  end

end
