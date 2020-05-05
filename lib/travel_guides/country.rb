class Country
  attr_accessor :name, :url, :continent

  @@all = []

  def initialize(country_hash)
    country_hash.each do |key, value|
      self.send("#{key}=", value)
      self.class.all << self
    end
  end

  def self.all
    @@all
  end
end
