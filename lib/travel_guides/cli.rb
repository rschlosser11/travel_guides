class CommandLine
  def call
    puts "Welcome to travel guides!"
    puts ""
    puts "Please wait while we load the regions to which you can travel:"
    puts ""
    # put list of continents/regions to choose from
    display_continents
    puts ""
    # ask user to select continent/region they wish to travel
    # display the countries in that continent
    display_countries
    # ask user what country

    # display overview of that country
    # OPTIONAL add other options about traveling to specific country (Things to Do, Shopping/Nightlife, Food/Drink)
    # menu to return to list of countries, to return to list of continents, or to exit
  end

  def display_continents
    # NEED TO check to see if continents created already
    Scraper.get_continents
    Continent.all.each_with_index {|continent, index| puts "#{index + 1}. #{continent.name}"}
  end

  def display_countries
    puts "Please type the number of the region you want to visit:"
    input = gets.strip
    input = input.to_i if input != 'exit'
    continent = Continent.all[input - 1] if input != 'exit'
    # NEED TO Check to see if the continent's countries have been called already
    Scraper.get_countries(continent)
    Country.find_by_continent(continent.name).each {|country| puts country.name}
    puts "Please select a region from the given list or type 'exit'"
    self.exit if input == 'exit'
  end

  def exit
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
    exit
  end
end
