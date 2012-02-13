module Service
  def self.services
    @@services ||= Hash.new
  end

  def self.invoke(key, params)
    if services[key]
      services[key].perform(params)
    else
      raise ArgumentError, "Unknown service key #{key.inspect}."
    end
  end
end

Dir[File.join(File.dirname(__FILE__), "services/**")].each { |file| require file }
