module Hammer

  module ENV

    class << self

      def base_path 
        @base_path  ||= Vim.evaluate 'fnamemodify(expand("<sfile>"), ":p:h")'
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
