module Hammer

  class << self

    def render template
      template = ERB.new File.read(File.join(Hammer::ENV.template_path, "#{template}.erb.html")) 
      template.result binding 
    end

  end
 
end
