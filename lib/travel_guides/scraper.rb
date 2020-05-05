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
  def self.get_countries
    # change the array to be an array of hashes for each country
    countries = []
    self.get_doc.css('#africa .menu-columns li').each_with_index do |country, index|
      country_hash = {
        :name => "#{self.get_doc.css('#africa .menu-columns li')[index].text}",
        :url => "#{self.get_doc.css('#africa .menu-columns li').css('a')[index]['href']}",
        :continent => "Africa"
      }
      countries << country_hash
    end
    # create a new instance of country for each hash
    countries.each {|country| Country.new(country)}
  end
  # Get overview of the country chosen by the user
end
