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

  def self.find_or_create_by_name(name)
    if self.all.find {|continent| continent.name == name}
      self.all.find {|continent| continent.name == name}
    else
      self.new(name)
    end
  end
end
