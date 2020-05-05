class Country
  attr_accessor :name, :url

  @@all = []

  def self.new_from_scrape
    Scraper.new.get_hash_from_scrape.each do |country|
      new_country = Country.new
      @@all << new_country
      country.each do |key, value|
        new_country.send("#{key}=", value)
      end
    end
  end

  def self.all
    @@all
  end
end
