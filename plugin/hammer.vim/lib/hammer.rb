module Hammer

  class << self

    def render
      template = ERB.new File.read(File.join(Hammer::ENV.template_path, "#{Hammer::ENV.template}.erb.html")) 
      template.result binding 
    end

  end
 
end
