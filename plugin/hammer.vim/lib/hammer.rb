module Hammer
  
  class << self
    
    #
    # @return [Array<String>] 
    #   List of dependencies required for Hammer to boot.
    #
    def dependencies
      @dependencies ||= 
      [
        "rubygems", 
        "hammer/env" , 
        "vim/improvedbuffer", 
        "erb", 
        "shellwords",
        "github/markup"
      ]
    end

    #
    # @return [Boolean]
    #   Could hammer load all its dependencies?
    #
    def dependencies_met?
      dependencies == met_dependencies 
    end

    #
    # @return [Array<String>]
    #   A list of dependencies hammer could load successfully.
    #
    def met_dependencies
      @met_depedencies ||= []
    end

    #
    # Loads all dependencies from {dependencies}.
    # @return [void] 
    #
    def load_dependencies! 
      dependencies.each do |dependency| 
        begin 
          require(dependency) 
        rescue LoadError 
        else
          met_dependencies << dependency
        end
      end
    end

    #
    # @return [Array<String>]
    #   A list of dependencies hammer cannot load.
    #
    def missing_dependencies 
      @dependencies - @met_dependencies 
    end

    # 
    # @param [String] path
    #   The path to a file to open with {Hammer::ENV.browser} 
    #
    # @return [void]
    #
    def open_browser path
      browser_path = Shellwords.escape(Hammer::ENV.browser)
      file_path    = Shellwords.escape(path)

      Vim.command "silent ! #{browser_path} #{file_path}" 
      Vim.command "redraw!"
    end

    def erb
      template = ERB.new File.read(Hammer::ENV.template) 
      template.result binding 
    end

    def render! buffer
      if dependencies_met? 
        if GitHub::Markup.can_render? buffer.basename
          path = File.join Hammer::ENV.directory, "#{buffer.basename}.html"

          File.open path, 'w' do |f|
            f.write Hammer.erb {
              GitHub::Markup.render(buffer.basename, buffer[0..-1]) 
            }
          end
        
          Hammer.open_browser path
        elsif buffer.extname =~ /^\.(xhtml|html)$/
          Hammer.open_browser buffer.name
        else
          Vim.message "It is not possible to render #{buffer.extname} files." \
                      "Missing dependency?" 
        end
      else
        Vim.message "Hammer could not load all its dependencies." 
      end
    end
  end

end
