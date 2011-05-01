module Hammer

  module ENV

    class << self

      def template
        @template = File.join Vim.evaluate('g:HammerTemplate')
      end

      def directory
        @directory = Vim.evaluate 'g:HammerDirectory'
      end

      def browser 
        @browser = Vim.evaluate 'g:HammerBrowser'
      end

      def base_path
        @base_path  ||= Vim.evaluate 'g:HammerLocation'
      end
      
      def template_path
        @template_path ||= File.join self.base_path, 'templates'
      end

      def stylesheet_path
        @stylesheet_path ||= File.join self.base_path, 'stylesheets'
      end

    end

  end

end
