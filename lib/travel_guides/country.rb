class TravelGuides::Country
  attr_accessor :name, :url, :continent

  @@all = []

  def initialize(country_hash)
    country_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.find{|country| country.name == name}
  end

  def self.find_or_create_by_hash(hash)
    if self.find_by_name(hash['name'])
      self.find_by_name(hash['name'])
    else
      self.new(hash)
    end
  end

  def self.find_by_continent(continent)
    self.all.select{|country| country.continent == continent}
  end
end
