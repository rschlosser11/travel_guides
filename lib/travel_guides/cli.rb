class Interface
  def call
    welcome
    # put list of cities/locations in country selected
    select_city
    # put the overview of the city selected
  end

  def welcome
    puts "Welcome to travel guides!"
    # put a list of of the available countries to choose from
    puts "Please select the number of the country you want to travel to:"
    @country_num = gets.strip.to_i
  end

  def select_city
    puts "Please select the number of the city you wish to travel: "
    @city_num = gets.strip.to_i
  end

  def exit
    puts "Thank you for exploring Travel Guides! See you for your next adventure!"
  end
end
