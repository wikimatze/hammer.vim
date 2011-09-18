module Vim::ImprovedBuffer

  # Adds a more Ruby-like interface to Vim::Buffer#[].
  #
  # @param  [Fixnum, Range] key
  # @return [String]
  def [] key
    if key.is_a? Range
      bufsize  = self.count
      key      = bufsize - (key.begin).abs .. key.end if key.begin < 0
      key      = key.begin .. bufsize - (key.end).abs if key.end < 0

      key.map { |number| super number + 1 }.join "\n"
    else
      super number + 1
    end
  end

  # The filename of a buffer.
  #
  # @return [String]
  def basename
    File.basename self.name.to_s
  end

  # The file extension of a buffer.
  #
  # @return [String]
  def extname
    File.extname self.name.to_s
  end

  # Ask the buffer if it exists on disk.
  # 
  # @return [Boolean] 
  def saved?
    File.exist? self.name.to_s
  end

  # The contents of the buffer.
  #
  # @return [String]
  def to_s
    self[0..-1]
  end

end

