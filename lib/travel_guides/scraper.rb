class Scraper
  # Get document
  def get_doc
    Nokogiri::HTML(open('https://www.worldtravelguide.net/country-guides/'))
  end
  # Get list of continents
  def get_continents
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
    continents
  end
  # Get list of countries
  def get_countries
    self.get_doc.css('#africa .menu-columns li')
  end
  # change output of #get_countries to an array of hashes
  def get_hash_from_scrape
    countries = []
    Scraper.new.get_countries.each_with_index do |country, index|
      country_hash = {
        :name => "#{Scraper.new.get_doc.css('#africa .menu-columns li')[index].text}",
        :url => "#{Scraper.new.get_doc.css('#africa .menu-columns li').css('a')[index]['href']}"
      }
      countries << country_hash
    end
    countries
  end
  # Get overview of the country chosen by the user
end
