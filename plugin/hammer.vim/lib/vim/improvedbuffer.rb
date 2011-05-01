module Vim

  module ImprovedBuffer

    def [] key
      if key.is_a? Range
        if key.end < 0
          key = key.begin .. self.count - (key.end + 1).abs 
        end

        key.map do |number|
          super number 
        end.join "\n"
      else
        super
      end
    end

    def basename
      File.basename self.name
    end

    def extname
      File.extname self.name
    end

  end

end

