class Continent
  attr_accessor :name

  @@all = [];

  def initialize(name)
    @name = name
  end

  def self.new_from_scrape
    Scraper.new.get_continents.each {|continent_name| self.all << Continent.new(continent_name)}
  end

  def self.all
    @@all
  end
end
