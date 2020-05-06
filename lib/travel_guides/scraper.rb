class Scraper
  # Get document
  def self.get_doc
    Nokogiri::HTML(open('https://www.worldtravelguide.net/country-guides/'))
  end
  # Get list of continents
  def self.get_continents
    continents = [];
    continents << self.get_doc.css('.africa').text
    continents << self.get_doc.css('.antarctica').text
    continents << self.get_doc.css('.asia').text
    continents << self.get_doc.css('.caribbean').text
    continents << self.get_doc.css('.europe').text
    continents << self.get_doc.css('.middle-east').text
    continents << self.get_doc.css('.north-america').text
    continents << self.get_doc.css('.oceania').text
    continents << self.get_doc.css('.south-america').text
    continents.each {|continent_name| Continent.new(continent_name)}
  end
  # Get list of countries
  def self.get_countries(continent)
    # change the array to be an array of hashes for each country
    self.get_doc.css("#africa .menu-columns li").each_with_index do |country, index|
      country_hash = {
        :name => "#{self.get_doc.css("#africa .menu-columns li")[index].text}",
        :url => "#{self.get_doc.css("#africa .menu-columns li").css("a")[index]["href"]}",
        :continent => Continent.find_or_create_by_name(continent.name)
      }
      Country.find_or_create_by_hash(country_hash)
    end
  end
  # Get overview of the country chosen by the user
  def self.get_travel_info(country)
    doc = Nokogiri::HTML(open("https://www.worldtravelguide.net#{country.url}"))
    about_country = doc.css("div[itemprop='text'] > p").text
  end
end
