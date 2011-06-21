require 'open3'

module Hammer
  class ExtendedMarkdown

    def initialize text
      @method      = text.respond_to?(:each_line) ? :each_line : :each
      @text        = text.send(@method).to_a
      @startpoint  = nil
      @endpoint    = nil
      @language    = nil
      @finished    = false
    end

    def parse!
      while @finished == false
        @finished = catch :break, &method(:iterate).to_proc
      end
      @text.join
    end

    private 

    def iterate symbol 
      @text.each.with_index do |line, index|
        @startpoint = index if line =~ /^```(\w+)$/ 
        @language   = $1    if $1 != nil 
        @endpoint   = index if line =~ /^```$/

        if @startpoint && @endpoint   
          @text[@startpoint] = nil 
          @text[@endpoint]   = nil 
          
          Open3.popen3 "pygmentize -l #{@language} -f html" do |stdin, stdout|
            stdin.write @text[@startpoint..@endpoint]
            stdin.close
            @text[@startpoint..@endpoint] = *stdout.read.send(@method).to_a
          end

          @startpoint = nil
          @endpoint   = nil
          @language   = nil

          throw symbol, false
        end
      end

      throw symbol, true
    end

  end
end
