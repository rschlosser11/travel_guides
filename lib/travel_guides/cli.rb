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
    Continent.all.each {|continent| puts continent.name}
  end

  def display_countries
    puts "Please type the name of the region you want to visit:"
    input = gets.strip.downcase
    # Check to see if the continent has been called already
  end

  def exit
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
  end
end
