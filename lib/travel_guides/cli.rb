class TravelGuides::CommandLine
  @@font = TTY::Font.new(:straight)
  @@pastel = Pastel.new
  def call
    puts @@pastel.cyan.bold(@@font.write("Welcome  to  travel  guides!"))
    puts ""
    puts "Please wait while we load the regions to which you can travel:"
    self.display_continents
    puts "Please type the number of the region you want to visit or type 'exit'."
    self.run
  end

  def run
    @continent_input = ''
    @country_input = ''
    @last_input = ''
    self.continent_menu(@continent_input, @country_input, @last_input)
  end

  def continent_menu(continent_input, country_input, last_input)
    @continent_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
    continent_input = @continent_input
    country_input = @country_input
    last_input = @last_input
    if TravelGuides::Continent.find_by_name(continent_input)
      display_countries(@continent_input)
      puts "Please type the name of the country/state that you'd like to explore\n or type 'regions' to return to the region list \n or type 'exit'"
      @country_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
      self.country_menu(continent_input, country_input, last_input)
    elsif @continent_input.downcase == 'exit'
      puts ""
      self.leave
    else
      puts ""
      puts @@pastel.red("Please type the name of a valid region or 'exit'.")
      self.continent_menu(continent_input, country_input, last_input)
    end
  end

  def country_menu(continent_input, country_input, last_input)
    continent_input = @continent_input
    country_input = @country_input
    last_input = @last_input
    if @country_input.downcase == 'regions'
      self.display_continents
      puts "Please type the number of the region you want to visit or type 'exit'."
      puts ""
      self.continent_menu(continent_input, country_input, last_input)
      puts ""
    elsif @country_input.downcase == 'exit'
      self.leave
    elsif TravelGuides::Country.find_by_name(@country_input)
      display_travel_info(@country_input)
      puts "To return to the country/state list type 'countries'\n to return to the region list type 'regions'\n to exit type 'exit'."
      @last_input = gets.strip.downcase
      self.last_menu(continent_input, country_input, last_input)
    else
      puts ""
      puts @@pastel.red("Please type the name of a country/state from the list.")
      @country_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
      puts ""
      self.country_menu(continent_input, country_input, last_input)
    end
  end

  def last_menu(continent_input, country_input, last_input)
    continent_input = @continent_input
    country_input = @country_input
    last_input = @last_input
    if @last_input == 'exit'
      self.leave
    elsif @last_input == 'regions'
      self.display_continents
      puts ""
      puts "Please type the number of the region you want to visit or type 'exit'."
      self.continent_menu(continent_input, country_input, last_input)
    elsif @last_input == 'countries'
      display_countries(continent_input)
      puts ""
      puts "Please type the name of the country/state that you'd like to explore\n or type 'regions' to return to the region list \n or type 'exit'"
      puts ""
      @country_input = gets.strip.split(" ").map{|word| word.capitalize}.join(" ")
      self.country_menu(continent_input, country_input, last_input)
    else
      puts ""
      puts @@pastel.red("Please enter 'exit', 'regions', or 'countries'!")
      @last_input = gets.strip.downcase
      self.last_menu(continent_input, country_input, last_input)
    end
  end

  def display_continents
    # check to see if continents created already
    if TravelGuides::Continent.all.length == 0
      TravelGuides::Scraper.get_continents
      puts ""
      puts "--------------------------"
      TravelGuides::Continent.all.each {|continent| puts "#{@@pastel.cyan(continent.name)}"}
      puts "--------------------------"
      puts ""
    else
      puts ""
      puts "--------------------------"
      TravelGuides::Continent.all.each {|continent| puts "#{@@pastel.cyan(continent.name)}"}
      puts "--------------------------"
      puts ""
    end
  end

  def display_countries_columns(continent)
    countries = TravelGuides::Country.find_by_continent(continent)
    index = 0
    while index < countries.length
      if index % 3 == 0 && index != 0 && index != countries.length - 1
        puts "#{@@pastel.cyan(countries[index - 3].name.ljust(30))}   #{@@pastel.cyan(countries[index -2].name.ljust(30))}   #{@@pastel.cyan(countries[index - 1].name.ljust(30))}"
      elsif countries.length == 1
        puts "#{@@pastel.cyan(countries[index].name.ljust(30))}"
      elsif index == countries.length - 1 && index % 3 == 0
        puts "#{@@pastel.cyan(countries[index - 3].name.ljust(30))}   #{@@pastel.cyan(countries[index -2].name.ljust(30))}   #{@@pastel.cyan(countries[index - 1].name.ljust(30))}"
        puts "#{@@pastel.cyan(countries[index].name.ljust(30))}"
      elsif index == countries.length - 1 && index % 2 == 0
        puts "#{@@pastel.cyan(countries[index - 1].name.ljust(30))}   #{@@pastel.cyan(countries[index].name.ljust(30))}"
      elsif index == countries.length - 1 && index % 2 == 1
        puts "#{@@pastel.cyan(countries[index].name.ljust(30))}"
      end
      index += 1
    end
  end

  def display_countries(input)
    continent = TravelGuides::Continent.all.find{|continent| continent.name == input}
    # NEED TO Check to see if the continent's countries have been called already
    if TravelGuides::Country.find_by_continent(continent).length == 0
      puts ""
      puts "Please wait while we generate a list of countries you can visit. This may take a bit depending on the region!"
      # puts "#{continent.name}"
      TravelGuides::Scraper.get_countries(continent)
      puts ""
      puts "--------------------------"
      puts "#{@@pastel.cyan.bold(@@font.write(@continent_input))}"
      display_countries_columns(continent)
      puts "--------------------------"
      puts ""
    else
      puts ""
      puts "--------------------------"
      puts "#{@@pastel.cyan.bold(@@font.write(@continent_input))}"
      display_countries_columns(continent)
      puts "--------------------------"
      puts ""
    end
  end

  def leave
    puts ""
    puts @@pastel.cyan.bold("Thank you for exploring Travel Guides! See you for your next adventure!")
    puts ""
    exit
  end

  def display_travel_info(country_input)
    country = TravelGuides::Country.find_by_name(country_input)
    travel_info = TravelGuides::Scraper.get_travel_info(country)
    while travel_info.index(/[\.!?]\w/)
      travel_info = travel_info.insert(travel_info.index(/[\.!?]\w/) + 1, "\n\n")
    end
    puts ""
    puts "--------------------------"
    puts "#{@@pastel.cyan.bold(@@font.write(country_input.upcase))}"
    puts WordWrap.ww "#{@@pastel.cyan(travel_info)}", 100
    puts "--------------------------"
    puts ""
  end
end
