class CommandLine
  def call
    puts "Welcome to travel guides!"
    puts ""
    puts "Please wait while we load the regions to which you can travel:"
    self.start
    # put list of continents/regions to choose from
  end

  def start
    puts ""
    display_continents
    puts ""
    puts "Please type the name of the region you want to visit or type 'exit'."
    continent_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
    # display_countries_and_menu(continent_input)
    puts ""
    if continent_input.downcase == 'exit'
      self.leave
    elsif Continent.find_or_create_by_name(continent_input)
      self.display_countries(continent_input)
    else
      "Please enter a valid input."
      self.start
    end
    # ask user to select continent/region they wish to travel
    # display the countries in that continent
    # ask user what country
    puts ""
    puts "Please type the name of the country from the given list \n or type 'regions' to return to the region list \n or type 'exit'"
    puts ""
    country_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
    # display_travel_info_and_menu(country_input, continent_input)
    if country_input.downcase == 'regions'
      self.start
    elsif country_input.downcase == 'exit'
      self.leave
    elsif Country.find_by_name(country_input)
      self.display_travel_info(country_input)
    else
      "Please enter a valid input."
      self.start
    end
    # display overview of that country
    # OPTIONAL add other options about traveling to specific country (Things to Do, Shopping/Nightlife, Food/Drink)
    # menu to return to list of countries, to return to list of continents, or to exit
    puts ""
    puts "To go back to the list of countries type 'countries', \nto return to the list of regions type 'regions', \nto exit type 'exit'."
    final_input = gets.strip.downcase
    if final_input == 'exit'
      self.leave
    elsif final_input == "regions"
      self.start
    elsif final_input == 'countries'
      self.display_countries(continent_input)
    else
      "Please enter a valid input."
      self.start
    end
  end

  def display_continents
    # NEED TO check to see if continents created already
    if Continent.all.length == 0
      Scraper.get_continents
      Continent.all.each {|continent| puts continent.name}
    else
      Continent.all.each {|continent| puts continent.name}
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
    continent = Continent.all.find{|continent| continent.name == input}
    puts "Please wait while we generate a list of countries you can visit. This may take a bit depending on the region!"
    puts ""
    # NEED TO Check to see if the continent's countries have been called already
    if Country.find_by_continent(continent).length == 0
      Scraper.get_countries(continent)
      countries = Country.find_by_continent(continent)
      index = 0
      while index < countries.length
        if index % 3 == 0 && index != 0 && index != countries.length - 1
          puts "#{countries[index - 3].name.ljust(30)}   #{countries[index -2].name.ljust(30)}   #{countries[index - 1].name.ljust(30)}"
        elsif countries.length == 1
          puts "#{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 3 == 0
          puts "#{countries[index - 3].name.ljust(30)}   #{countries[index -2].name.ljust(30)}   #{countries[index - 1].name.ljust(30)}"
          puts "#{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 2 == 0
          puts "#{countries[index - 1].name.ljust(30)}   #{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 2 == 1
          puts "#{countries[index].name.ljust(30)}"
        end
        index += 1
      end
    else
      countries = Country.find_by_continent(continent)
      index = 0
      while index < countries.length
        if index % 3 == 0 && index != 0 && index != countries.length - 1
          puts "#{countries[index - 3].name.ljust(30)}   #{countries[index -2].name.ljust(30)}   #{countries[index - 1].name.ljust(30)}"
        elsif countries.length == 1
          puts "#{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 3 == 0
          puts "#{countries[index - 3].name.ljust(30)}   #{countries[index -2].name.ljust(30)}   #{countries[index - 1].name.ljust(30)}"
          puts "#{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 2 == 0
          puts "#{countries[index - 1].name.ljust(30)}   #{countries[index].name.ljust(30)}"
        elsif index == countries.length - 1 && index % 2 == 1
          puts "#{countries[index].name.ljust(30)}"
        end
        index += 1
      end
    end
  end

  def leave
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
    exit
  end

  def display_travel_info(country_input)
    country = Country.find_by_name(country_input)
    puts WordWrap.ww "#{Scraper.get_travel_info(country)}", 100
  end

  def display_countries_and_menu(continent_input)
    if continent_input.downcase == 'exit'
      self.leave
    elsif Continent.find_or_create_by_name(continent_input)
      self.display_countries(continent_input)
    else
      "Please enter a valid input."
      self.display_countries_and_menu(continent_input)
    end
  end

  # def display_travel_info_and_menu(country_input, continent_input)
  #   if country_input.downcase == 'regions'
  #     self.display_continents
  #     self.display_countries_and_menu(continent_input)
  #   elsif country_input.downcase == 'exit'
  #     self.leave
  #   elsif Country.find_by_name(country_input)
  #     self.display_travel_info(country_input)
  #     self.final_menu
  #   else
  #     "Please enter a valid input."
  #     self.display_travel_info_and_menu
  #   end
  # end

  # def final_menu(country_input)
  #   puts ""
  #   puts "To go back to the list of countries type 'countries', \nto return to the list of regions type 'regions', \nto exit type 'exit'."
  #   final_input = gets.strip
  #   if final_input.downcase == 'countries'
  #     self.display_countries_and_menu(Country.find_by_name(country_input).name)
  #   elsif final_input.downcase == 'regions'
  #     self.start
  #   elsif final_input.downcase == 'exit'
  #     self.leave
  #   else
  #     "Please enter a valid input. \nTo go back to the list of countries type 'back', \nto return to the list of regions type 'regions', \nto exit type 'exit'."
  #     self.final_menu
  #   end
  # end
end
