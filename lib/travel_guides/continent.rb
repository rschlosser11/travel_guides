class Continent
  attr_accessor :name

  @@all = [];

  def initialize(name)
    @name = name
    self.class.all << self
  end

  def self.all
    @@all
  end
end
