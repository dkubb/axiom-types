class Encoding
  UTF_8    = new
  UTF_16BE = new

  def self.list
    []
  end
end unless defined?(::Encoding)
