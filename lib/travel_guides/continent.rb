class TravelGuides::Continent
  attr_accessor :name

  @@all = [];

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    continent_name = name.split.map {|word| word.capitalize}.join(" ")
    self.all.find {|continent| continent.name == continent_name}
  end

  def self.find_or_create_by_name(name)
    continent_name = name.split.map {|word| word.capitalize}.join(" ")
    if self.all.find {|continent| continent.name == continent_name}
      self.all.find {|continent| continent.name == continent_name}
    else
      self.new(name)
    end
  end
end
