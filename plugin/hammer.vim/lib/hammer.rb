module Hammer

  class << self

    def render
      template = ERB.new File.read("#{Hammer::ENV.template}.erb.html") 
      template.result binding 
    end

  end
 
end
