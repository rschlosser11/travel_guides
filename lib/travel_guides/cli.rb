class Interface
  def call
    puts "Welcome to travel guides!"
    # put list of continents/regions to choose from
    # ask user to select continent/region they wish to travel
    # display the countries in that continent
    # ask user what country
    # display overview of that country
    # OPTIONAL add other options about traveling to specific country (Things to Do, Shopping/Nightlife, Food/Drink)
    # menu to return to list of countries, to return to list of continents, or to exit
  end

  def select_continent
    puts "Please select the number of the continent you wish to travel: "
    @city_num = gets.strip.to_i
  end

  def exit
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
  end
end
