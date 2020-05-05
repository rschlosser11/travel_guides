class Scraper
  # Get document
  def get_doc
    Nokogiri::HTML(open('https://www.worldtravelguide.net/country-guides/'))
  end
  # Get list of regions
  def get_and_put_regions
    puts self.get_doc.css('.africa').text
    puts self.get_doc.css('.antarctica').text
    puts self.get_doc.css('.asia').text
    puts self.get_doc.css('.caribbean').text
    puts self.get_doc.css('.europe').text
    puts self.get_doc.css('.middle-east').text
    puts self.get_doc.css('.north-america').text
    puts self.get_doc.css('.oceania').text
    puts self.get_doc.css('.south-america').text
  end
  # Get list of countries
  def get_countries
    self.get_doc.css('#africa .menu-columns li')
  end
  # Get overview of the country chosen by the user
end
