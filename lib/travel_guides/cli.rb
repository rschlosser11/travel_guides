class CommandLine
  def call
    puts "Welcome to travel guides!"
    puts ""
    puts "Please wait while we load the regions to which you can travel:"
    puts ""
    # put list of continents/regions to choose from
    display_continents
    display_countries_and_menu
    # ask user to select continent/region they wish to travel
    # display the countries in that continent
    # ask user what country
    display_travel_info_and_menu
    # display overview of that country
    final_menu
    # OPTIONAL add other options about traveling to specific country (Things to Do, Shopping/Nightlife, Food/Drink)
    # menu to return to list of countries, to return to list of continents, or to exit
  end

  def display_continents
    # NEED TO check to see if continents created already
    if Continent.all.length == 0
      Scraper.get_continents
      Continent.all.each_with_index {|continent, index| puts "#{index + 1}. #{continent.name}"}
    else
      Continent.all.each_with_index {|continent, index| puts "#{index + 1}. #{continent.name}"}
    end
  end

  # def display_countries(input)
  #   input = input.to_i
  #   continent = Continent.all[input - 1]
  #   puts "Please wait while we generate a list of countries you can visit. This may take a bit depending on the region!"
  #   # NEED TO Check to see if the continent's countries have been called already
  #   if Country.find_by_continent(continent).length == 0
  #     Scraper.get_countries(continent)
  #     Country.find_by_continent(continent).each_with_index {|country, index| puts "#{index + 1}. #{country.name}"}
  #   else
  #     Country.find_by_continent(continent).each_with_index {|country, index| puts "#{index + 1}. #{country.name}"}
  #   end
  # end
  def display_countries(input)
    input = input.to_i
    continent = Continent.all[input - 1]
    puts "Please wait while we generate a list of countries you can visit. This may take a bit depending on the region!"
    # NEED TO Check to see if the continent's countries have been called already
    if Country.find_by_continent(continent).length == 0
      Scraper.get_countries(continent)
      countries = Country.find_by_continent(continent)
      index = 0
      while index < countries.length
        if index % 4 == 0 && index != 0
          puts "#{countries[index - 4].name.ljust(16)} \t #{countries[index -3].name.ljust(16)} \t #{countries[index - 2].name.ljust(16)} \t #{countries[index - 1].name.ljust(16)}"
        end
        index += 1
      end
    else
      countries = Country.find_by_continent(continent)
      index = 0
      while index < countries.length
        if index % 4 == 0 && index != 0
          puts "#{countries[index - 4].name.ljust(16)} \t #{countries[index -3].name.ljust(16)} \t #{countries[index - 2].name.ljust(16)} \t #{countries[index - 1].name.ljust(16)}"
        end
        index += 1
      end
    end
  end

  def leave
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
    exit
  end

  def display_travel_info(input)
    input = input.to_i
    country = Country.all[input - 1]
    puts Scraper.get_travel_info(country).fit
  end

  def display_countries_and_menu
    puts ""
    puts "Please type the number of the region you want to visit or type 'exit'."
    continent_input = gets.strip
    if continent_input.downcase == 'exit'
      self.leave
    elsif continent_input.to_i.between?(1, Continent.all.length)
      self.display_countries(continent_input)
    else
      "Please enter a valid input."
      self.display_countries_and_menu
    end
  end

  def display_travel_info_and_menu
    puts ""
    puts "Please select the number of the country from the given list \n or type 'back' to return to the region list \n or type 'exit'"
    country_input = gets.strip
    if country_input.downcase == 'back'
      self.display_continents
    elsif country_input.downcase == 'exit'
      self.leave
    elsif country_input.to_i.between?(1, Country.all.length)
      self.display_travel_info(country_input)
    else
      "Please enter a valid input."
      self.display_travel_info_and_menu
    end
  end

  def final_menu
    puts ""
    puts "To go back to the list of countries type 'back', \nto return to the list of regions type 'regions', \nto exit type 'exit'."
    final_input = gets.strip
    if final_input.downcase == 'back'
      self.display_countries(country_input)
    elsif final_input.downcase == 'regions'
      self.display_continents
    elsif final_input.downcase == 'exit'
      self.leave
    else
      "Please enter a valid input. \nTo go back to the list of countries type 'back', \nto return to the list of regions type 'regions', \nto exit type 'exit'."
      self.final_menu
    end
  end
end
