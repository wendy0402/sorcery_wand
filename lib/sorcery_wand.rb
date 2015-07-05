module SorceryWand
  class << self
    attr_accessor :config
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
